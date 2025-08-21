part of '../create_room_dialog.dart';

class _GridIconSelector extends StatefulWidget {
  const _GridIconSelector({required this.onChanged});

  final ValueChanged<IconData> onChanged;

  @override
  State<_GridIconSelector> createState() => _GridIconSelectorState();
}

class _GridIconSelectorState extends State<_GridIconSelector> {
  final List<IconData> icons = [
    Icons.bed,
    Icons.home,
    Icons.light,
    Icons.forest,
    Icons.grass,
    Icons.bathroom,
  ];

  int selectIndex = 1;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: icons.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemBuilder: (context, index) => IconButton(
        icon: Icon(
          icons[index],
          color: selectIndex == index
              ? Theme.of(context).colorScheme.primary
              : null,
        ),
        onPressed: () {
          setState(() {
            selectIndex = index;
            widget.onChanged(icons[index]);
          });
        },
        style: IconButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          overlayColor: Colors.transparent,
        ),
      ),
    );
  }
}
