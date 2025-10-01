import 'dart:io';
import 'package:equatable/equatable.dart';

/// ImagePickItem
class ImagePickItem extends Equatable {
  /// ImagePickItem
  const ImagePickItem({
    this.id,
    this.path,
    this.mimeType,
    this.file,
  });

  /// image id
  final String? id;

  /// image path
  final String? path;

  /// image mime type
  final String? mimeType;

  /// image file
  final File? file;

  /// copyWith
  ImagePickItem copyWith({
    String? id,
    String? path,
    String? mimeType,
    File? file,
  }) {
    return ImagePickItem(
      id: id ?? this.id,
      path: path ?? this.path,
      mimeType: mimeType ?? this.mimeType,
      file: file ?? this.file,
    );
  }

  @override
  List<Object?> get props => [id, path, mimeType, file];
}
