import 'package:clone_insta/product/create_post/view_model/create_post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// ViewModel for CreatePostView
class CreatePostViewModel extends Cubit<CreatePostState> {
  /// Constructor
  CreatePostViewModel() : super(const CreatePostInitial());

  /// Simulates post upload process
  Future<void> uploadPost() async {
    emit(const CreatePostUploading());
    await Future<void>.delayed(const Duration(seconds: 3));
    emit(const CreatePostUploaded());
  }
}
