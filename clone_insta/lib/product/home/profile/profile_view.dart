import 'package:auto_route/auto_route.dart';
import 'package:clone_insta/feature/components/profile_avatar.dart';
import 'package:clone_insta/feature/constants/app_sizes.dart';
import 'package:clone_insta/feature/extensions/context_theme_extension.dart';
import 'package:clone_insta/feature/models/profile_model.dart';
import 'package:flutter/material.dart';

part 'profile_mixin.dart';
part 'widgets/profile_info.dart';

@RoutePage()
/// ProfileView
class ProfileView extends StatefulWidget {
  /// ProfileView
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with _ProfileMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Thixq'),
      ),
      body: Column(
        children: [
          _ProfileInfo(
            profile: ProfileModel.mock(),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
