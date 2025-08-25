import 'package:flutter/material.dart';

///Only Asset Image Show
class ShowCard extends StatelessWidget {
  const ShowCard({
    super.key,
    required this.image,
    required this.title,
    required this.onPressed,
  });
  final String image;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.zero,
      ),
      clipBehavior: Clip.hardEdge,
      onPressed: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AspectRatio(
              aspectRatio: 9 / 16,
              child: Image.asset(image, fit: BoxFit.fitHeight),
            ),
            FractionallySizedBox(
              heightFactor: .5,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: AlignmentGeometry.topCenter,
                    end: AlignmentGeometry.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Theme.of(context).colorScheme.surface,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
