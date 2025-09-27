part of '../create_post_view.dart';

class _PostButton extends StatelessWidget {
  const _PostButton({
    this.isEnabled = false,
    this.onPressed,
    this.isUploading = false,
    super.key,
  });

  final VoidCallback? onPressed;
  final bool isUploading;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w(context),
      child: FilledButton(
        onPressed: isEnabled ? onPressed : null,
        child: isUploading
            ? const CircularProgressIndicator.adaptive()
            : const Text('Post'),
      ),
    );
  }
}
