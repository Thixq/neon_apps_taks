part of '../create_post_view.dart';

class _PostImagePicker extends StatelessWidget {
  const _PostImagePicker({super.key, this.onTap, this.pickedItem});

  final VoidCallback? onTap;
  final HLPickerItem? pickedItem;

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
          child: pickedItem == null
              ? null
              : Image.file(
                  File(pickedItem!.path),
                  fit: BoxFit.contain,
                ),
        ),
      ),
    );
  }
}
