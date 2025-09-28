import 'package:clone_insta/feature/models/user_preview_model.dart';
import 'package:clone_insta/feature/utils/enums/relationship_enums.dart';

final class UserWithFriendship {
  const UserWithFriendship({
    required this.user,
    required this.follow,
    required this.block,
  });
  final UserPreviewModel user;
  final FollowStatus follow;
  final BlockStatus block;
}
