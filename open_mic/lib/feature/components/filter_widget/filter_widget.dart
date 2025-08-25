// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:open_mic/feature/components/filter_widget/filter_model.dart';

class FilterWidget<T> extends StatefulWidget implements PreferredSizeWidget {
  const FilterWidget({
    super.key,
    required this.filters,
    required this.onSeleced,
  });

  final List<FilterModel<T>> filters;
  final ValueChanged<T?> onSeleced;

  @override
  State<FilterWidget<T>> createState() => _FilterWidgetState<T>();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _FilterWidgetState<T> extends State<FilterWidget<T>> {
  T? selectedTag;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      children: widget.filters
          .map(
            (tag) => FilterChip(
              label: Text(tag.text),
              selected: tag.value == selectedTag,
              onSelected: (isSelected) {
                setState(() {
                  if (isSelected) {
                    selectedTag = tag.value;
                    widget.onSeleced(tag.value);
                  } else {
                    selectedTag = null;
                    widget.onSeleced(null);
                  }
                });
              },
            ),
          )
          .toList(),
    );
  }
}
