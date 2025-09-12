import 'dart:io';
import 'package:auto_route/annotations.dart';
import 'package:clone_insta/feature/constants/app_sizes.dart';
import 'package:clone_insta/feature/extensions/context_theme_extension.dart';
import 'package:clone_insta/feature/extensions/num_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hl_image_picker_ios/hl_image_picker_ios.dart';

part 'create_post_mixin.dart';
part 'widgets/post_image_picker.dart';
part 'widgets/caption_text_field.dart';
part 'widgets/post_button.dart';

@RoutePage()
/// CreatePostView
class CreatePostView extends StatefulWidget {
  /// CreatePostView
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView>
    with _CreatePostViewMixin {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            loading = !loading;
          });
        },
      ),
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.small),
          child: Column(
            spacing: AppSizes.large,
            children: [
              _PostImagePicker(
                onTap: _pick,
                pickedItem: _pickedItem,
              ),
              const _CaptionTextField(),
              _PostButton(
                isUpLoading: loading,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
