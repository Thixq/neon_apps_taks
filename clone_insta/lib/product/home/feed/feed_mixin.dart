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
    _getFeed();
    _profileManager = DependencyContainer.profileManager;
    _feedManager = DependencyContainer.feedManager;
    _commentManager = DependencyContainer.commentManager;
    super.initState();
  }

  Future<void> _getFeed() async {
    // geçici
    await _feedManager.fetchFeed(_profileManager.profile!.id);
  }
}
