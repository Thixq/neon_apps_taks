/// Represents follow-up situations.
enum FollowStatus {
  /// does not follow
  none,

  /// Follow request sent
  pending,

  /// Following
  active,
}

/// Represents blocking states.
enum BlockStatus {
  /// No blocking
  none,

  /// Blocked
  blocked,
}
