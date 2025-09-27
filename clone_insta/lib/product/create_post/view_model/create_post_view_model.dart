import 'package:clone_insta/feature/services/image_picker_service.dart';
import 'package:clone_insta/product/create_post/view_model/create_post_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

/// ViewModel for CreatePostView
class CreatePostViewModel extends Cubit<CreatePostState> {
  /// Constructor
  CreatePostViewModel({
    required ImagePickerService imagePickerService,
  }) : _imagePickerService = imagePickerService,

       super(const CreatePostState());

  final ImagePickerService _imagePickerService;

  /// Simulates post upload process
  Future<void> uploadPost() async {
    if (state.picker is SelectedState) {
      final selected = state.picker as SelectedState;
      if (selected.photo.file == null) return;

      emit(state.copyWith(upload: const UploadingState()));
    }
  }

  /// image picker
  Future<void> imagePick() async {
    emit(state.copyWith(picker: const UnselectedState()));
    final image = await _imagePickerService.openImagePicker();
    emit(
      state.copyWith(
        picker: image != null ? SelectedState(image) : const UnselectedState(),
      ),
    );
  }
}
