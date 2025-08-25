part of '../home_view.dart';

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar({required this.onSeleced});

  final void Function(ShowCategory?) onSeleced;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Open Mic'),
      bottom: FilterWidget<ShowCategory>(
        filters: ShowCategory.values
            .map((e) => FilterModel(value: e, text: e.name))
            .toList(),
        onSeleced: onSeleced,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + kToolbarHeight);
}
