import 'package:firebase_storage/firebase_storage.dart';

/// The loading process is complete. The result will be returned.
final class UploadResultModel {
  /// Creates an instance of [UploadResultModel].
  UploadResultModel({
    required this.path,
    required this.downloadUrl,
    this.metadata,
  });

  /// The path of the uploaded file
  final String path;

  /// The download URL of the uploaded file
  final String downloadUrl;

  /// The metadata of the uploaded file
  final FullMetadata? metadata;

  /// Creates a copy of this [UploadResultModel] with the given parameters.
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
