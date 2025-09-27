part of '../create_post_view.dart';

class _CaptionTextField extends StatelessWidget {
  const _CaptionTextField({
    super.key,

    this.controller,
    this.onChanged,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      onTapUpOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      onChanged: onChanged,
      controller: controller,
      maxLines: 4,
      minLines: 2,
      decoration: const InputDecoration(hintText: 'Write a caption...'),
    );
  }
}
