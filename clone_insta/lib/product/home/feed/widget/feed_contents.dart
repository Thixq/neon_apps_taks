part of '../feed_view.dart';

class _FeedContents extends StatelessWidget {
  const _FeedContents({
    required this.commentManager,
    this.posts,
    super.key,
    this.profile,
  });

  final List<PopulatedPostModel>? posts;
  final ProfileModel? profile;
  final CommentManager? commentManager;

  @override
  Widget build(BuildContext context) {
    return posts == null
        ? const Center(child: Text('Posts not found'))
        : ListView.separated(
            itemBuilder: (context, index) {
              final post = posts![index];
              return PostCard(
                commentPressed: () {
                  CommentBottomSheet.show(
                    context,
                    postId: post.id,
                    profile: profile,
                    manager: commentManager,
                  );
                },

                post: post,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: posts!.length,
          );
  }
}
