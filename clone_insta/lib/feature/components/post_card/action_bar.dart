part of 'post_card.dart';

final class _ActionBar extends StatelessWidget {
  const _ActionBar({
    List<_ActionItem>? prefixActions,
    List<_ActionItem>? suffixActions,
  }) : _prefixActions = prefixActions,
       _suffixActions = suffixActions;

  final List<_ActionItem>? _prefixActions;
  final List<_ActionItem>? _suffixActions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: _prefixActions ?? [],
            ),
          ),
        ),

        SingleChildScrollView(
          reverse: true,
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: _suffixActions ?? [],
          ),
        ),
      ],
    );
  }
}
