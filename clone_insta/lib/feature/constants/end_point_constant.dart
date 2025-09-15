/// Constants for endpoints
final class EndPointConstant {
  const EndPointConstant._();

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
}
