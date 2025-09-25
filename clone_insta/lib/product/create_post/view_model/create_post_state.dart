import 'dart:io';
import 'package:clone_insta/feature/models/image_pick_item.dart';
import 'package:equatable/equatable.dart';

/// State for the "create post" flow
final class CreatePostState extends Equatable {
  /// Default state: no photo selected, no upload in progress
  const CreatePostState({
    this.picker = const Unselected(),
    this.upload = const Idle(),
  });

  /// Current photo picker state (selected/unselected)
  final PhotoPickerState picker;

  /// Current upload state (idle, uploading, uploaded, error)
  final UploadState upload;

  /// Creates a new state with updated values
  CreatePostState copyWith({
    PhotoPickerState? picker,
    UploadState? upload,
  }) {
    return CreatePostState(
      picker: picker ?? this.picker,
      upload: upload ?? this.upload,
    );
  }

  @override
  List<Object?> get props => [picker, upload];
}

// --- UI State

/// Base state for the photo picker
sealed class PhotoPickerState extends Equatable {
  const PhotoPickerState();
  @override
  List<Object?> get props => [];
}

/// No photo selected
final class Unselected extends PhotoPickerState {
  /// No photo selected
  const Unselected();
}

/// A photo has been selected
final class Selected extends PhotoPickerState {
  /// A photo has been selected
  const Selected(this.photo);

  /// Selected photo
  final ImagePickItem photo;

  @override
  List<Object?> get props => [
    photo.id,
    photo.path,
    photo.mimeType,
  ];
}

// --- Upload State

/// Base state for photo uploading
sealed class UploadState extends Equatable {
  /// Base state for photo uploading
  const UploadState();
  @override
  List<Object?> get props => [];
}

/// Upload not started yet
final class Idle extends UploadState {
  /// Upload not started yet
  const Idle();
}

/// Upload is in progress
final class Uploading extends UploadState {
  /// Upload is in progress
  const Uploading({this.progress = 0.0});

  /// Upload progress
  final double progress;

  @override
  List<Object?> get props => [progress];
}

/// Upload finished successfully
final class Uploaded extends UploadState {
  /// Upload finished successfully
  const Uploaded(this.url);

  /// Uploaded URL
  final String url;

  @override
  List<Object?> get props => [url];
}

/// Upload failed with an error
final class UploadError extends UploadState {
  /// Upload failed with an error
  const UploadError(this.message);

  /// Error message
  final String message;

  @override
  List<Object?> get props => [message];
}
