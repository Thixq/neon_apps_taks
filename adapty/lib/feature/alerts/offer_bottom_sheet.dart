import 'package:flutter/material.dart';

class OfferBottomSheet {
  static Future<void> show(
    BuildContext context, {
    required VoidCallback standard,
    required VoidCallback plus,
    required VoidCallback ultimate,
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
                  title: 'Standard',
                  subTitle: '10\$ per month',
                  content: '10 notes per day',
                  onPressed: () {
                    standard();
                    Navigator.pop(context);
                  },
                ),
                _buildOffter(
                  title: 'Plus',
                  subTitle: '30\$ per month',
                  content: '50 notes per day',
                  titleStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  onPressed: () {
                    plus();
                    Navigator.pop(context);
                  },
                ),
                _buildOffter(
                  title: 'Ultimate',
                  subTitle: '100\$ per month',
                  content: '100 notes per day',
                  onPressed: () {
                    ultimate();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static TextButton _buildOffter({
    required String title,
    required String subTitle,
    required String content,
    required VoidCallback onPressed,
    TextStyle? titleStyle,
    TextStyle? subTitleStyle,
    TextStyle? contentStyle,
  }) {
    return TextButton(
      onPressed: onPressed,
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
