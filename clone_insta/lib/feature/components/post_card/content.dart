part of 'post_card.dart';

final class _Content extends StatelessWidget {
  const _Content({this.contentImage});

  final String? contentImage;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorScheme.surface,
      child: AspectRatio(
        aspectRatio: 4 / 5,
        child: contentImage == null
            ? Container()
            : CachedNetworkImage(
                fit: BoxFit.fitWidth,
                imageUrl: contentImage!,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                placeholder: (context, url) =>
                    const CircularProgressIndicator.adaptive(),
              ),
      ),
    );
  }
}
