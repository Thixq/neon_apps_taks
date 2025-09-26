// ManagedUpload: upload'un runtime temsilcisi
import 'package:clone_insta/feature/controllers/upload_task_controller.dart';
import 'package:clone_insta/feature/models/upload_models/upload_result_model.dart';
import 'package:clone_insta/feature/utils/enums/upload_status.dart';

/// Class that holds the loading process information
class ManagedUpload {
  /// Constructor
  ManagedUpload({
    required this.id,
    required this.path,
    required this.controller,
    this.progress = 0.0,
    this.status = UploadStatus.queued,
  }) : createdAt = DateTime.now();

  /// Upload id
  final String id;

  /// Upload path
  final String path;

  /// Upload controller
  final UploadTaskController controller;

  /// Upload creation date
  final DateTime createdAt;

  /// Upload status
  UploadStatus status;

  /// Upload progress
  double progress;

  /// Upload result
  UploadResultModel? result;

  /// Upload error
  Object? error;
}
