part of 'post_card.dart';

final class _ActionItem extends StatefulWidget {
  const _ActionItem({
    required this.onPressed,
    this.selectedIcon,
    this.unselectedIcon,
    this.icon,
  }) : assert(
         (selectedIcon != null && unselectedIcon != null) || icon != null,
         'A pair of selected/unselected icons or a single icon should be provided.',
       );

  final Icon? selectedIcon;
  final Icon? unselectedIcon;
  final Icon? icon;

  final VoidCallback? onPressed;

  @override
  State<_ActionItem> createState() => _ActionItemState();
}

class _ActionItemState extends State<_ActionItem> {
  bool isSelected = false;

  bool get hasToggle =>
      widget.selectedIcon != null && widget.unselectedIcon != null;

  @override
  Widget build(BuildContext context) {
    final Icon displayedIcon;

    if (hasToggle) {
      displayedIcon = isSelected
          ? widget.selectedIcon!
          : widget.unselectedIcon!;
    } else {
      displayedIcon = widget.icon!;
    }

    return IconButton(
      onPressed: widget.onPressed == null
          ? null
          : () {
              if (hasToggle) {
                setState(() {
                  isSelected = !isSelected;
                });
              }
              widget.onPressed?.call();
            },
      icon: displayedIcon,
      style: const ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateProperty.fromMap({
          WidgetState.pressed: Colors.transparent,
          WidgetState.any: null,
        }),
      ),
    );
  }
}
