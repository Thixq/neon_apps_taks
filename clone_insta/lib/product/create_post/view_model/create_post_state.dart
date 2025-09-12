/// Post creation states
sealed class CreatePostState {
  const CreatePostState();
}

/// Initial state
final class CreatePostInitial extends CreatePostState {
  /// Constructor
  const CreatePostInitial();
}

/// Post Create and Uploading state
final class CreatePostUploading extends CreatePostState {
  /// Constructor
  const CreatePostUploading();
}

/// Post Create and Uploaded state
final class CreatePostUploaded extends CreatePostState {
  /// Constructor
  const CreatePostUploaded();
}
