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
                  subTitle: '10₺ per month',
                  onPressed: standard,
                ),
                _buildOffter(
                  onPressed: plus,
                  title: 'Plus',
                  subTitle: '30₺ per month',
                  titleStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildOffter(
                  title: 'Ultimate',
                  subTitle: '100₺ per month',
                  onPressed: ultimate,
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
    required VoidCallback onPressed,
    TextStyle? titleStyle,
    TextStyle? subTitleStyle,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: titleStyle),
          Text(subTitle, style: subTitleStyle),
        ],
      ),
    );
  }
}
