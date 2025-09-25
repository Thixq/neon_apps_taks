// ManagedUpload: upload'un runtime temsilcisi
import 'package:clone_insta/feature/controllers/upload_task_controller.dart';
import 'package:clone_insta/feature/models/upload_models/upload_result_model.dart';
import 'package:clone_insta/feature/utils/enums/upload_status.dart';

class ManagedUpload {
  ManagedUpload({
    required this.id,
    required this.path,
    required this.controller,
    this.progress = 0.0,
    this.status = UploadStatus.queued,
  }) : createdAt = DateTime.now();

  final String id;
  final String path;
  final UploadTaskController controller;

  final DateTime createdAt;
  UploadStatus status;
  double progress;
  UploadResultModel? result;
  Object? error;
}
