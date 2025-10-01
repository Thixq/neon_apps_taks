import 'package:clone_insta/feature/models/user_preview_model.dart';
import 'package:clone_insta/feature/utils/enums/relationship_enums.dart';

/// User with their friendship status
final class UserWithFriendship {
  /// Constructor
  const UserWithFriendship({
    required this.user,
    required this.follow,
    required this.block,
  });

  /// User with their friendship status
  final UserPreviewModel user;

  /// Friendship status
  final FollowStatus follow;

  /// Block status
  final BlockStatus block;
}
