// ignore_for_file: prefer_if_elements_to_conditional_expressions, document_ignores

part of 'post_card.dart';

final class _ContentInfo extends StatelessWidget {
  const _ContentInfo({
    required this.likeCount,
    required this.byLastComment,
    required this.lastComment,
    this.caption,
  });

  final int? likeCount;
  final String? byLastComment;
  final String? lastComment;
  final String? caption;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.small),
      child: Column(
        spacing: AppSizes.small,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildText(
            context,
            text: '$likeCount',
            subTitle: 'Likes',
            maxLines: 1,
          ),
          caption != null
              ? _buildContentDescription(
                  context,
                  contentDescription: caption,
                )
              : const SizedBox.shrink(),
          _buildText(
            context,
            text: byLastComment,
            subTitle: lastComment,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildContentDescription(
    BuildContext context, {
    String? contentDescription,
  }) {
    return ReadMoreText(
      '$contentDescription',
      trimMode: TrimMode.Line,
      delimiter: ' ',
      style: context.textTheme.bodyMedium,
      moreStyle: context.textTheme.bodyMedium?.copyWith(
        color: context.theme.colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
      lessStyle: context.textTheme.bodyMedium?.copyWith(
        color: context.theme.colorScheme.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildText(
    BuildContext context, {
    String? text,
    String? subTitle,
    int? maxLines,
  }) {
    return RichText(
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: text,
        style: context.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        children: [
          text != null ? const TextSpan(text: ' ') : const TextSpan(text: ''),
          TextSpan(text: subTitle, style: context.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
