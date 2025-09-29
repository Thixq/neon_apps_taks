import 'package:auto_route/auto_route.dart';
import 'package:clone_insta/feature/constants/app_sizes.dart';
import 'package:clone_insta/feature/extensions/context_theme_extension.dart';
import 'package:clone_insta/feature/extensions/num_extension.dart';
import 'package:clone_insta/feature/init/dependency_injection/dependency_container.dart';
import 'package:clone_insta/feature/models/image_pick_item.dart';
import 'package:clone_insta/product/create_post/view_model/create_post_state.dart';
import 'package:clone_insta/product/create_post/view_model/create_post_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreatePostViewModel(
        imagePickerService: DependencyContainer.service.imagePicker,
        postManager: DependencyContainer.manager.postManager,
        profileManager: DependencyContainer.manager.profileManager,
        storageService: DependencyContainer.service.storage,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Post'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.small),
            child: Column(
              spacing: AppSizes.large,
              children: [
                BlocBuilder<CreatePostViewModel, CreatePostState>(
                  buildWhen: (previous, current) =>
                      previous.picker != current.picker,
                  builder: (context, state) {
                    return _PostImagePicker(
                      onTap: () => _pickImage(context),
                      pickedItem: (state.picker is SelectedState
                          ? (state.picker as SelectedState).photo
                          : null),
                    );
                  },
                ),
                _CaptionTextField(
                  controller: _captionController,
                ),
                BlocBuilder<CreatePostViewModel, CreatePostState>(
                  builder: (context, state) {
                    return _PostButton(
                      onPressed: () => _createPost(context),
                      isUploading: state.upload is UploadingState,
                      isEnabled:
                          state.picker is SelectedState &&
                          state.upload is IdleState,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
