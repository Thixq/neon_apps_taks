/// Constants for endpoints
final class EndPointConstant {
  const EndPointConstant._();

  // --- collections ---

  ///  users collection
  static const String users = 'users';

  /// sub-collection for quick viewing of one's followers
  static const String followersSeed = 'followers';

  ///  sub-collection for quick viewing of what one follows
  static const String followingSeed = 'following';

  /// a collection of shared logs between people
  ///
  ///  example: block status
  static const String relationships = 'relationships';

  /// sub-collection of independent relationships between people
  ///
  ///  example: mute status
  static const String relationshipsSide = 'side';

  ///  comments collection
  static const String comments = 'comments';

  ///  posts collection
  static const String posts = 'posts';

  /// devices fcm token collection
  static const String devices = 'devices';

  // --- query parameters ---

  ///  query for end point
  static const String userId = 'userId';

  ///  query for end point
  static const String startAfter = 'startAfter';

  ///  query for end point
  static const String createdAt = 'createdAt';

  ///  query for end point
  static const String sides = 'sides';

  ///  query for end point
  static const String followStatus = 'followStatus';
}
