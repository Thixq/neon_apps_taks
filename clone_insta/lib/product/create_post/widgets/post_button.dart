part of '../create_post_view.dart';

class _PostButton extends StatelessWidget {
  const _PostButton({this.onPressed, this.isUpLoading = true, super.key});

  final VoidCallback? onPressed;
  final bool isUpLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w(context),
      child: FilledButton(
        onPressed: isUpLoading ? null : onPressed,
        child: isUpLoading
            ? const CircularProgressIndicator.adaptive()
            : const Text('Post'),
      ),
    );
  }
}
