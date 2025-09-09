part of '../feed_view.dart';

class _FeedContents extends StatelessWidget {
  const _FeedContents({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.small),
          child: PostCard(
            post: PopulatedPostModel.mock(),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: 12,
    );
  }
}
