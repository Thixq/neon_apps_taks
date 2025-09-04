import 'package:cached_network_image/cached_network_image.dart';
import 'package:clone_insta/feature/constants/app_sizes.dart';
import 'package:flutter/material.dart';

/// A circular avatar that can be tapped.
final class ProfileAvatar extends StatelessWidget {
  /// Creates a circular avatar that can be tapped.
  const ProfileAvatar({super.key, this.imageUrl, this.onPressed});

  /// The URL of the avatar image.
  final String? imageUrl;

  /// A callback which is called when the avatar is tapped.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CircleAvatar(
        minRadius: AppSizes.medium,
        maxRadius: AppSizes.large,
        child: ClipOval(
          child: imageUrl != null && imageUrl!.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                  width: AppSizes.extraLarge * 2,
                  height: AppSizes.extraLarge * 2,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator.adaptive(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : const Icon(Icons.person),
        ),
      ),
    );
  }
}
