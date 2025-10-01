part of '../profile_view.dart';

class _ProfileContent extends StatefulWidget {
  const _ProfileContent({
    required this.postsLoading,
    super.key,
    this.posts,
    this.savedPosts,
  });

  final List<PopulatedPostModel?>? posts;
  final List<PopulatedPostModel?>? savedPosts;
  final bool postsLoading;

  @override
  State<_ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<_ProfileContent> {
  late bool postsLoading;

  @override
  void initState() {
    postsLoading = widget.postsLoading;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _ProfileContent oldWidget) {
    if (oldWidget.postsLoading != widget.postsLoading) {
      setState(() {
        postsLoading = widget.postsLoading;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          splashFactory: NoSplash.splashFactory,
          indicatorColor: context.colorScheme.onSurface,
          tabs: const [
            Tab(icon: Icon(Icons.grid_on_outlined)),
            Tab(icon: Icon(Icons.bookmark_border)),
          ],
        ),
        body: TabBarView(
          children: [
            if (postsLoading)
              const Center(child: CircularProgressIndicator.adaptive())
            else
              _ContentGrid(
                contents: widget.posts,
              ),
            _ContentGrid(
              contents: widget.savedPosts,
            ),
          ],
        ),
      ),
    );
  }
}
