part of 'feed_view.dart';

mixin _FeedMixin on State<FeedView> {
  late final ProfileManager _profileManager;
  late final FeedManager _feedManager;
  late final CommentManager _commentManager;
  void _navigateToCreatePost() {
    context.router.push(const CreatePostRoute());
  }

  @override
  void initState() {
    _profileManager = DependencyContainer.manager.profileManager;
    _feedManager = DependencyContainer.manager.feedManager;
    _commentManager = DependencyContainer.manager.commentManager;
    _getFeed();
    super.initState();
  }

  Future<void> _getFeed() async {
    // geçici
    await _feedManager.fetchFeed(_profileManager.profile!.id);
  }
}
