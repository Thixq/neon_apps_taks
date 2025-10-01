part of '../profile_view.dart';

class _ContentGrid extends StatelessWidget {
  const _ContentGrid({super.key, this.contents});

  final List<PopulatedPostModel?>? contents;

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
        return post?.contentImageUrl == null ? null : ContentImage(post: post);
      },
    );
  }
}

/// Represents the image of a post.
class ContentImage extends StatelessWidget {
  /// Creates a new instance of [ContentImage].
  const ContentImage({
    required this.post,
    super.key,
  });

  /// The post to display the image for.
  final PopulatedPostModel? post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (detail) async {
        final tmpDir = await getTemporaryDirectory();

        if (context.mounted) {
          await ImageContextMenu.show(
            context,
            position: detail.globalPosition,
            fileManager: DependencyContainer.manager.fileManager,
            pathOrUrl: post!.contentImageUrl!,
            outputFile: File('${tmpDir.path}/downloaded_image.jpg'),
          );
        }
      },
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: post!.contentImageUrl!,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
