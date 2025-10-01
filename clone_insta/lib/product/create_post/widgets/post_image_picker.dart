part of '../create_post_view.dart';

class _PostImagePicker extends StatelessWidget {
  const _PostImagePicker({super.key, this.onTap, this.pickedItem});

  final VoidCallback? onTap;
  final ImagePickItem? pickedItem;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: InkWell(
        onTap: onTap,
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainerHighest,
            border: Border.all(
              color: context.colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(AppSizes.large),
          ),
          child: pickedItem?.file == null
              ? null
              : Image.file(
                  pickedItem!.file!,
                  fit: BoxFit.contain,
                ),
        ),
      ),
    );
  }
}
