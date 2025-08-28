import 'package:flutter/material.dart';

class OfferBottomSheet {
  static Future<void> show(
    BuildContext context, {
    VoidCallback? standard,
    VoidCallback? plus,
    VoidCallback? ultimate,
  }) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 400,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildOffter(
                  context,
                  title: 'Standard',
                  subTitle: '10\$ per month',
                  content: '10 notes per day',
                  onPressed: standard?.call,
                ),
                _buildOffter(
                  context,
                  title: 'Plus',
                  subTitle: '30\$ per month',
                  content: '50 notes per day',
                  titleStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: plus?.call,
                ),
                _buildOffter(
                  context,
                  title: 'Ultimate',
                  subTitle: '100\$ per month',
                  content: '100 notes per day',
                  onPressed: ultimate?.call,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static TextButton _buildOffter(
    BuildContext context, {
    required String title,
    required String subTitle,
    required String content,
    VoidCallback? onPressed,
    TextStyle? titleStyle,
    TextStyle? subTitleStyle,
    TextStyle? contentStyle,
  }) {
    return TextButton(
      onPressed: onPressed == null
          ? null
          : () {
              onPressed.call();
              Navigator.pop(context);
            },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: titleStyle),
          Text(subTitle, style: subTitleStyle),
          Text(content, style: contentStyle),
        ],
      ),
    );
  }
}
