import 'dart:io';
import 'dart:typed_data';

import 'package:clone_insta/feature/managers/file_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

/// Image menu actions
enum ImageMenuAction {
  /// Download
  download,
}

/// Context menu for images
class ImageContextMenu {
  const ImageContextMenu._(); // private constructor

  /// Show the context menu
  static Future<void> show(
    BuildContext context, {
    required Offset position,
    required FileManager fileManager,
    required String pathOrUrl,
    required File outputFile,
  }) async {
    final action = await showMenu<ImageMenuAction>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: const [
        PopupMenuItem(
          value: ImageMenuAction.download,
          child: Text('⬇️ Download to Gallery'),
        ),
      ],
    );

    if (action == null) return;

    switch (action) {
      case ImageMenuAction.download:
        if (context.mounted) {
          await _handleDownload(context, fileManager, pathOrUrl, outputFile);
        }
    }
  }

  static Future<void> _handleDownload(
    BuildContext context,
    FileManager fileManager,
    String pathOrUrl,
    File outputFile,
  ) async {
    try {
      // 🔹 1. Dosyayı indir
      await fileManager.downloadFile(
        pathOrUrl: pathOrUrl,
        outputFile: outputFile,
      );

      // 🔹 2. İzin iste (Android için)
      final status = await Permission.photosAddOnly.request();
      debugPrint('status: $status');
      if (!status.isGranted) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('❌ Permission denied')),
          );
        }
        return;
      }

      // 🔹 3. Byte olarak oku
      final bytes = await outputFile.readAsBytes();

      // 🔹 4. Galeriye kaydet
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(bytes),
        quality: 100,
        name: 'firebase_image_${DateTime.now().millisecondsSinceEpoch}',
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ Downloaded to gallery: $result')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Download failed: $e')),
        );
      }
    }
  }
}
