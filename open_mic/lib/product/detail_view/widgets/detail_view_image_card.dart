part of '../detail_view.dart';

class _DetailViewImageCard extends StatelessWidget {
  const _DetailViewImageCard({this.imagePath});

  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 9 / 16,
        child: Image.asset(
          imagePath ?? '',
          fit: BoxFit.fitHeight,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Theme.of(context).colorScheme.errorContainer,
              child: Icon(Icons.error),
            );
          },
        ),
      ),
    );
  }
}
