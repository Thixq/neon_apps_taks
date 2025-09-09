part of '../profile_view.dart';

const String _editProfile = 'Edit Profile';
const String _share = 'Share';
const String _posts = 'Posts';
const String _followers = 'Followers';
const String _following = 'Following';

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo({this.profile});

  final ProfileModel? profile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSizes.mediumPadding,
      child: Column(
        spacing: AppSizes.extraLarge,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileInfo(context),
          _buildActions(),
        ],
      ),
    );
  }

  Row _buildActions() {
    return Row(
      spacing: AppSizes.small,
      children: [
        Expanded(
          child: FilledButton.tonal(
            onPressed: () {},
            child: const Text(_editProfile),
          ),
        ),
        Expanded(
          child: FilledButton.tonal(
            onPressed: () {},
            child: const Text(_share),
          ),
        ),
      ],
    );
  }

  Row _buildProfileInfo(BuildContext context) {
    return Row(
      spacing: AppSizes.extraLarge,
      children: [
        ProfileAvatar(
          size: AppSizes.extraLarge * 3,
          imageUrl: profile?.profileImage,
        ),
        Expanded(
          child: Column(
            spacing: AppSizes.small,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${profile?.nickName} ',
                style: context.textTheme.titleSmall,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoText(
                    context,
                    title: '${profile?.posts?.toCompactString()}',
                    text: _posts,
                  ),
                  _buildInfoText(
                    context,
                    title:
                        '${profile?.followers?.toCompactString(decimalDigits: 2)}',
                    text: _followers,
                  ),
                  _buildInfoText(
                    context,
                    title:
                        '${profile?.following?.toCompactString(decimalDigits: 1)}',
                    text: _following,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildInfoText(
    BuildContext context, {
    required String title,
    required String text,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium,
        ),
        Text(text),
      ],
    );
  }
}
