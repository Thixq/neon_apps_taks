import 'dart:io';

import 'package:clone_insta/feature/app_logger.dart';
import 'package:clone_insta/feature/models/image_pick_item.dart';
import 'package:flutter/services.dart';
import 'package:hl_image_picker_ios/hl_image_picker_ios.dart';

/// Service that handles image picking
final class ImagePickerService {
  /// Constructor
  const ImagePickerService({required HLImagePickerIOS picker})
    : _picker = picker;
  final HLImagePickerIOS _picker;

  /// Open image picker
  Future<ImagePickItem?> openImagePicker() async {
    AppLogger.log('📸 openPicker started');
    try {
      final result = await _picker.openPicker(
        pickerOptions: const HLPickerOptions(
          maxSelectedAssets: 1,
          usedCameraButton: true,
          mediaType: MediaType.image,
          compressQuality: 50,
          convertLivePhotosToJPG: true,
          convertHeicToJPG: true,
        ),
        cropping: true,
      );

      if (result.isEmpty) {
        AppLogger.log(
          '📸 openPicker finished — no item selected (user cancelled)',
        );
        return null;
      }
      final picked = result.first;
      AppLogger.log(
        '📸 item picked — identifier: ${picked.id}\npath: ${picked.path}\nmimeType: ${picked.mimeType}',
      );
      final imageItem = ImagePickItem(
        id: picked.id,
        path: picked.path,
        mimeType: picked.mimeType,
        file: File(picked.path),
      );
      return imageItem;
    } on PlatformException catch (error, stackTrace) {
      AppLogger.error(
        error,
        stackTrace,
        reason: '❌ PlatformException while opening image picker',
      );
      return null;
    } catch (error, stackTrace) {
      AppLogger.error(
        error,
        stackTrace,
        reason: '❌ Unexpected error while opening image picker',
      );
      return null;
    }
  }
}
