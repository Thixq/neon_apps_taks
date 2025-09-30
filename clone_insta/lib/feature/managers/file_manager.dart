import 'dart:io';

import 'package:clone_insta/feature/app_logger.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// Manager for file operations
final class FileManager {
  /// Constructor
  const FileManager({required FirebaseStorage firebaseStorage})
    : _firebaseStorage = firebaseStorage;

  final FirebaseStorage _firebaseStorage;

  /// Delete file from Firebase Storage
  Future<void> deleteFile(String pathOrUrl) async {
    try {
      final rawPath = _normalizePath(pathOrUrl);
      await _firebaseStorage.ref(rawPath).delete();

      AppLogger.log('File deleted successfully at path: $rawPath');
    } catch (e, st) {
      AppLogger.error(e, st, reason: 'File deletion failed: $pathOrUrl');
      rethrow;
    }
  }

  /// Download file to local storage
  Future<TaskSnapshot> downloadFile({
    required String pathOrUrl,
    required File outputFile,
  }) async {
    try {
      final rawPath = _normalizePath(pathOrUrl);
      AppLogger.log('Starting download for: $rawPath');

      final ref = _firebaseStorage.ref(rawPath);
      final task = await ref.writeToFile(outputFile);

      AppLogger.log('File downloaded to: ${outputFile.path}');
      return task;
    } catch (e, st) {
      AppLogger.error(e, st, reason: 'File download failed: $pathOrUrl');
      rethrow;
    }
  }

  /// Normalize Firebase Storage path or URL
  String _normalizePath(String pathOrUrl) {
    if (pathOrUrl.startsWith('http')) {
      final parsed = _extractStoragePath(pathOrUrl);
      if (parsed == null) {
        throw ArgumentError('Invalid Firebase Storage URL: $pathOrUrl');
      }
      return parsed;
    }
    return pathOrUrl;
  }

  /// Extract path from Firebase Storage download URL
  String? _extractStoragePath(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;

    final encodedPath = uri.pathSegments.contains('o')
        ? uri.pathSegments[uri.pathSegments.indexOf('o') + 1]
        : null;

    if (encodedPath == null) return null;

    return Uri.decodeComponent(encodedPath); // %2F -> /
  }
}
