import 'dart:async';

import 'package:clone_insta/feature/managers/post_manager.dart';
import 'package:clone_insta/feature/managers/profile_manager.dart';
import 'package:clone_insta/feature/models/post_model/post_models.dart';
import 'package:clone_insta/feature/services/image_picker_service.dart';
import 'package:clone_insta/product/create_post/view_model/create_post_state.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

/// ViewModel for CreatePostView
class CreatePostViewModel extends Cubit<CreatePostState> {
  /// Constructor
  CreatePostViewModel({
    required ImagePickerService imagePickerService,
    required FirebaseStorage storageService,
    required PostManager postManager,
    required ProfileManager profileManager,
  }) : _imagePickerService = imagePickerService,
       _storageService = storageService,
       _postManager = postManager,
       _profileManager = profileManager,
       super(const CreatePostState());

  final ImagePickerService _imagePickerService;
  final FirebaseStorage _storageService;
  final PostManager _postManager;
  final ProfileManager _profileManager;

  /// Upload photo and create post
  Future<void> createPost({String? caption}) async {
    emit(state.copyWith(upload: const UploadingState()));
    final contentUrl = await _uploadPhoto();
    if (contentUrl == null || _profileManager.profile?.id == null) {
      emit(
        state.copyWith(
          upload: const UploadErrorState('Photo upload failed'),
        ),
      );
      return;
    }
    final post = FirebasePostModel(
      id: '',
      userId: _profileManager.profile!.id,
      caption: caption,
      createdAt: DateTime.now(),
      contentImageUrl: contentUrl,
      likeCount: 0,
    );
    await _postManager.createPost(post);
    emit(state.copyWith(upload: const UploadedState()));
  }

  /// Upload photo to storage
  Future<String?> _uploadPhoto() async {
    if (state.picker is! SelectedState) return null;

    final selected = state.picker as SelectedState;
    if (selected.photo.file == null) return null;

    try {
      final ref = _storageService.ref().child(
        'posts/${selected.photo.id}',
      );
      final uploadTask = ref.putFile(
        selected.photo.file!,
        SettableMetadata(contentType: selected.photo.mimeType),
      );

      await uploadTask.whenComplete(() {});
      final url = await ref
          .getDownloadURL(); // Burada result.ref yerine ref kullan
      return url;
    } on FirebaseException catch (e) {
      // log at
      print('🔥 Upload failed: ${e.code} - ${e.message}');
      return null;
    }
  }

  /// image picker
  Future<void> imagePick() async {
    final image = await _imagePickerService.openImagePicker();
    if (image != null) {
      emit(state.copyWith(picker: SelectedState(image)));
    }
  }
}
