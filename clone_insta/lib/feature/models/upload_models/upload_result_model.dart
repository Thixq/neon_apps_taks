// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_storage/firebase_storage.dart';

final class UploadResultModel {
  UploadResultModel({
    required this.path,
    required this.downloadUrl,
    this.metadata,
  });
  final String path;
  final String downloadUrl;
  final FullMetadata? metadata;

  UploadResultModel copyWith({
    String? path,
    String? downloadUrl,
    FullMetadata? metadata,
  }) {
    return UploadResultModel(
      path: path ?? this.path,
      downloadUrl: downloadUrl ?? this.downloadUrl,
      metadata: metadata ?? this.metadata,
    );
  }
}
