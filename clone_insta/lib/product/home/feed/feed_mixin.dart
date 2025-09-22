part of 'feed_view.dart';

mixin _FeedMixin on State<FeedView> {
  void _navigateToCreatePost() {
    context.router.push(const CreatePostRoute());
  }

  @override
  void initState() {
    _getFeed();
    super.initState();
  }

  Future<void> _getFeed() async {
    await context.read<FeedViewModel>().getFeed();
  }
}
