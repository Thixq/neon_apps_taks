part of '../profile_view.dart';

class _ProfileContent extends StatefulWidget {
  const _ProfileContent({super.key, this.posts, this.savedPosts});

  final List<PopulatedPostModel>? posts;
  final List<PopulatedPostModel>? savedPosts;

  @override
  State<_ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<_ProfileContent> {
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
