// upload_task_controller.dart
import 'dart:async';

import 'package:clone_insta/feature/models/upload_models/upload_result_model.dart';
import 'package:clone_insta/feature/utils/enums/upload_status.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// Controls data uploads to Firebase Storage.
class UploadTaskController {
  /// Constructor
  UploadTaskController({
    required this.task,
    required this.result,
  }) {
    _statusController = StreamController<UploadStatus>.broadcast();

    _snapshotSub = task.snapshotEvents.listen(
      (snapshot) {
        switch (snapshot.state) {
          case TaskState.running:
            _statusController.add(UploadStatus.running);
          case TaskState.paused:
            _statusController.add(UploadStatus.paused);
          case TaskState.success:
            _statusController.add(UploadStatus.success);
          case TaskState.canceled:
            _statusController.add(UploadStatus.canceled);
          case TaskState.error:
            _statusController.add(UploadStatus.error);
        }
      },
      onError: (e) {
        _statusController.add(UploadStatus.error);
      },
    );
  }

  /// A class which indicates an on-going upload task.
  final UploadTask task;

  /// A future which resolves to the result of the upload.
  final Future<UploadResultModel> result;

  late final StreamController<UploadStatus> _statusController;
  late final StreamSubscription<TaskSnapshot> _snapshotSub;

  /// Streams the loading process.
  Stream<double> progressStream() => task.snapshotEvents.map((s) {
    final total = s.totalBytes;
    final transferred = s.bytesTransferred;
    if (total == 0) return 0.0;
    return transferred / total;
  });

  /// Streams the upload status.
  Stream<UploadStatus> statusStream() => _statusController.stream;

  /// Pauses the upload.
  Future<void> pause() async {
    try {
      final res = await task.pause();
      if (!res) throw Exception('Pause not supported for this task');
    } catch (e) {
      rethrow;
    }
  }

  /// Resumes the upload.
  Future<void> resume() async {
    try {
      final res = await task.resume();
      if (!res) throw Exception('Resume not supported for this task');
    } catch (e) {
      rethrow;
    }
  }

  /// Cancels the upload.
  Future<void> cancel() async {
    try {
      await task.cancel();
    } catch (e) {
      rethrow;
    }
  }

  /// Disposes the controller.
  void dispose() {
    _snapshotSub.cancel();
    _statusController.close();
  }
}
