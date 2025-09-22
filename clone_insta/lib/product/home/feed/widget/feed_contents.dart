part of '../feed_view.dart';

class _FeedContents extends StatelessWidget {
  const _FeedContents({this.posts, super.key});

  final List<PopulatedPostModel>? posts;

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
                    comments: List.generate(
                      13,
                      (index) => PopulatedCommentModel.mock(),
                    ),
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
