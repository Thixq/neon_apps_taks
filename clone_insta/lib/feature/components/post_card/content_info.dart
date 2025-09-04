part of 'post_card.dart';

final class _ContentInfo extends StatelessWidget {
  const _ContentInfo({
    required this.likeCount,
    required this.byLastComment,
    required this.lastComment,
  });

  final String? likeCount;
  final String? byLastComment;
  final String? lastComment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.small),
      child: Column(
        spacing: AppSizes.small,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildText(context, text: likeCount, subTitle: 'Likes'),
          _buildText(context, text: byLastComment, subTitle: lastComment),
        ],
      ),
    );
  }

  RichText _buildText(
    BuildContext context, {
    String? text,
    String? subTitle,
  }) {
    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: text,
        style: context.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        children: [
          const TextSpan(text: ' '),
          TextSpan(text: subTitle, style: context.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
