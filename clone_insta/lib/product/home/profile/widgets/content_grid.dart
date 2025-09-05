part of '../profile_view.dart';

class _ContentGrid extends StatelessWidget {
  const _ContentGrid({super.key, this.contents});

  final List<PostPreviewModel>? contents;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppSizes.extraSmall,
        mainAxisSpacing: AppSizes.extraSmall,
      ),
      itemCount: contents?.length,
      itemBuilder: (context, index) {
        final post = contents?[index];
        return post?.imagePath == null
            ? null
            : CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: post!.imagePath!,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              );
      },
    );
  }
}
