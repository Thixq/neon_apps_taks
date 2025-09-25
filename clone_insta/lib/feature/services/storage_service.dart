// FirebaseStorageService: IStorageService implementasyonu.
// Not: UploadTaskController ve UploadResultModel önceki implementasyonla uyumlu olmalı.
import 'dart:io';
import 'dart:typed_data';

import 'package:clone_insta/feature/controllers/upload_task_controller.dart';
import 'package:clone_insta/feature/models/upload_result_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:clone_insta/feature/app_logger.dart';

final class StorageService {
  StorageService({required FirebaseStorage storage}) : _storage = storage;
  final FirebaseStorage _storage;

  Reference _ref(String path) => _storage.ref().child(path);

  UploadTaskController startUpload({
    required String path,
    required File file,
    String? contentType,
    Map<String, String>? metadata,
  }) {
    final ref = _ref(path);
    final meta = SettableMetadata(
      contentType: contentType,
      customMetadata: metadata,
    );
    final task = ref.putFile(file, meta);

    final resultFuture = task
        .whenComplete(() async {
          final url = await ref.getDownloadURL();
          final fullMeta = await ref.getMetadata();
          return UploadResultModel(
            path: path,
            downloadUrl: url,
            metadata: fullMeta,
          );
        })
        .then((_) async {
          final url = await ref.getDownloadURL();
          final fullMeta = await ref.getMetadata();
          return UploadResultModel(
            path: path,
            downloadUrl: url,
            metadata: fullMeta,
          );
        });

    return UploadTaskController(task: task, result: resultFuture);
  }

  Future<UploadResultModel> uploadFile({
    required String path,
    required File file,
    String? contentType,
    Map<String, String>? metadata,
  }) async {
    try {
      final ref = _ref(path);
      final meta = SettableMetadata(
        contentType: contentType,
        customMetadata: metadata,
      );
      final task = ref.putFile(file, meta);
      await task.whenComplete(() {});
      final fullMeta = await ref.getMetadata();
      final url = await ref.getDownloadURL();
      AppLogger.log('✅ Uploaded file to $path');
      return UploadResultModel(
        path: path,
        downloadUrl: url,
        metadata: fullMeta,
      );
    } catch (e, st) {
      AppLogger.error(e, st, reason: '❌ uploadFile error for $path');
      rethrow;
    }
  }

  Future<UploadResultModel> uploadData({
    required String path,
    required Uint8List data,
    String? contentType,
    Map<String, String>? metadata,
  }) async {
    try {
      final ref = _ref(path);
      final meta = SettableMetadata(
        contentType: contentType,
        customMetadata: metadata,
      );
      final task = ref.putData(data, meta);
      await task.whenComplete(() {});
      final fullMeta = await ref.getMetadata();
      final url = await ref.getDownloadURL();
      AppLogger.log('✅ Uploaded bytes to $path');
      return UploadResultModel(
        path: path,
        downloadUrl: url,
        metadata: fullMeta,
      );
    } catch (e, st) {
      AppLogger.error(e, st, reason: '❌ uploadData error for $path');
      rethrow;
    }
  }

  Future<String> getDownloadUrl(String path) => _ref(path).getDownloadURL();

  Future<void> deleteFile(String path) async {
    try {
      await _ref(path).delete();
      AppLogger.log('🗑 Deleted file at $path');
    } catch (e, st) {
      AppLogger.error(e, st, reason: '❌ deleteFile error for $path');
      rethrow;
    }
  }

  Future<ListResult> listFiles(
    String path, {
    int maxResults = 100,
    String? pageToken,
  }) {
    final reference = _ref(path);
    return reference.list(
      ListOptions(maxResults: maxResults, pageToken: pageToken),
    );
  }

  Future<void> downloadToFile(
    String path,
    File outFile, {
    int? maxSizeBytes,
  }) async {
    try {
      final ref = _ref(path);
      if (maxSizeBytes != null) {
        final meta = await ref.getMetadata();
        final size = meta.size;
        if (size != null && size > maxSizeBytes) {
          throw Exception('File too large');
        }
      }
      final task = ref.writeToFile(outFile);
      await task.whenComplete(() {});
      AppLogger.log('⬇️ Downloaded $path to ${outFile.path}');
    } catch (e, st) {
      AppLogger.error(e, st, reason: '❌ downloadToFile error for $path');
      rethrow;
    }
  }
}
