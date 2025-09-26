/// Upload status
enum UploadStatus {
  /// Upload is not started
  queued,

  /// Upload is running
  running,

  /// Upload is paused
  paused,

  /// Upload is completed
  success,

  /// Upload is canceled
  canceled,

  /// Upload failed
  error,
}
