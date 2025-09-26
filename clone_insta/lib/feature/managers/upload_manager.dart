import 'dart:async';
import 'dart:io';

import 'package:clone_insta/feature/app_logger.dart';
import 'package:clone_insta/feature/models/upload_models/managed_upload.dart';
import 'package:clone_insta/feature/services/storage_service.dart';
import 'package:clone_insta/feature/utils/enums/upload_status.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

/// Manages asynchronous data upload operations to Firebase Storage.
final class UploadManager {
  /// Constructor
  UploadManager({
    required StorageService storageService,
  }) : _storage = storageService;

  final StorageService _storage;

  final _uuid = const Uuid();

  // id -> ManagedUpload
  final Map<String, ManagedUpload> _uploads = {};

  // broadcast stream of current uploads snapshot (copy of list)
  final _uploadsController = StreamController<List<ManagedUpload>>.broadcast();

  /// Stream of current uploads
  Stream<List<ManagedUpload>> get uploadsStream => _uploadsController.stream;

  /// Current uploads
  List<ManagedUpload> get currentUploads => _uploads.values.toList();

  /// Starts the file upload process
  ManagedUpload startUpload({
    required String path,
    required File file,
    String? contentType,
    Map<String, String>? metadata,
  }) {
    final id = _uuid.v4();
    // Start the upload via storage service - returns controller
    final controller = _storage.startUpload(
      path: path,
      file: file,
      contentType: contentType,
      metadata: metadata,
    );

    final mu = ManagedUpload(id: id, path: path, controller: controller);
    _uploads[id] = mu;

    // listen progress + status
    _listenToControllers(mu);

    _emit();

    AppLogger.log('▶️ Started upload $id -> $path');

    return mu;
  }

  /// Returns upload by id
  ManagedUpload? getUpload(String id) => _uploads[id];

  /// Pauses upload
  Future<void> pauseUpload(String id) async {
    final m = _uploads[id];
    if (m == null) return;
    try {
      await m.controller.pause();
      m.status = UploadStatus.paused;
      _emit();
    } catch (e, st) {
      AppLogger.error(e, st, reason: 'pauseUpload failed for $id');
      rethrow;
    }
  }

  /// Resumes upload
  Future<void> resumeUpload(String id) async {
    final m = _uploads[id];
    if (m == null) return;
    try {
      await m.controller.resume();
      m.status = UploadStatus.running;
      _emit();
    } catch (e, st) {
      AppLogger.error(e, st, reason: 'resumeUpload failed for $id');
      rethrow;
    }
  }

  /// Cancels upload
  Future<void> cancelUpload(String id) async {
    final m = _uploads[id];
    if (m == null) return;
    try {
      await m.controller.cancel();
      m.status = UploadStatus.canceled;
      _emit();
    } catch (e, st) {
      AppLogger.error(e, st, reason: 'cancelUpload failed for $id');
      rethrow;
    }
  }

  /// Remove upload from manager (call after success/error if you want)
  void removeUpload(String id) {
    _uploads.remove(id);
    _emit();
  }

  /// Fetch files page via storage service (passthrough)
  Future<ListResult> fetchFilesPage(
    String path, {
    int maxResults = 100,
    String? pageToken,
  }) {
    return _storage.listFiles(
      path,
      maxResults: maxResults,
      pageToken: pageToken,
    );
  }

  /// Disposes the manager
  void dispose() {
    for (final u in _uploads.values) {
      // optionally cancel/listen cleanup
      u.controller.dispose();
    }
    _uploads.clear();
    _uploadsController.close();
  }

  // --- internals ---
  void _listenToControllers(ManagedUpload m) {
    // progress
    m.controller.progressStream().listen(
      (p) {
        m.progress = p;
        if (m.status != UploadStatus.running) {
          m.status = UploadStatus.running;
        }
        _emit();
      },
      onError: (e) {
        m
          ..error = e
          ..status = UploadStatus.error;
        _emit();
      },
    );

    // status
    m.controller.statusStream().listen(
      (s) {
        // map UploadStatus (from controller) -> ManagedUploadStatus
        switch (s) {
          case UploadStatus.queued:
            m.status = UploadStatus.queued;
          case UploadStatus.running:
            m.status = UploadStatus.running;
          case UploadStatus.paused:
            m.status = UploadStatus.paused;
          case UploadStatus.success:
            m.status = UploadStatus.success;
          case UploadStatus.canceled:
            m.status = UploadStatus.canceled;
          case UploadStatus.error:
            m.status = UploadStatus.error;
        }
        _emit();
      },
      onError: (e) {
        m
          ..error = e
          ..status = UploadStatus.error;
        _emit();
      },
    );

    // result future (finalize)
    m.controller.result
        .then((res) {
          m
            ..result = res
            ..status = UploadStatus.success
            ..progress = 1.0;
          _emit();
          // optionally auto-remove after success? keep for history
        })
        .catchError((e) {
          m
            ..error = e
            ..status = UploadStatus.error;
          _emit();
        });

    // When we dispose/remove upload we should cancel subscriptions.
    // For simplicity keep references on ManagedUpload? (left as exercise)
  }

  void _emit() {
    // safe copy snapshot
    final list = _uploads.values.toList(growable: false);
    if (!_uploadsController.isClosed) _uploadsController.add(list);
  }
}
