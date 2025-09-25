import 'package:clone_insta/feature/services/image_picker_service.dart';
import 'package:clone_insta/product/create_post/view_model/create_post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// ViewModel for CreatePostView
class CreatePostViewModel extends Cubit<CreatePostState> {
  /// Constructor
  CreatePostViewModel({required ImagePickerService imagePickerService})
    : _imagePickerService = imagePickerService,
      super(const CreatePostState());

  final ImagePickerService _imagePickerService;

  /// Simulates post upload process
  Future<void> uploadPost() async {
    if (state.picker is! Selected) {
      emit(state.copyWith(upload: const Uploading()));
    }
  }

  /// image picker
  Future<void> imagePick() async {
    emit(state.copyWith(picker: const Unselected()));
    final image = await _imagePickerService.openImagePicker();
    emit(
      state.copyWith(
        picker: image != null ? Selected(image) : const Unselected(),
      ),
    );
  }
}
