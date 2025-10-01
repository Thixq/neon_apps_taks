part of '../feed_view.dart';

class _ShimmerContents extends StatelessWidget {
  const _ShimmerContents({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: PostCard(
            commentPressed: () {},
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: 2,
    );
  }
}
