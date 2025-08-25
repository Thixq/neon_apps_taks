// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.onPressed,
    required this.imageUrl,
  });

  final VoidCallback onPressed;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipOval(
        child: InkWell(
          splashColor: Colors.transparent,
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          onTap: onPressed,
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(),
                color: Theme.of(context).colorScheme.errorContainer,
              ),
              child: Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
