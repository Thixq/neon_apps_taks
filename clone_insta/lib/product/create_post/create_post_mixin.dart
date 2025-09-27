part of 'create_post_view.dart';

mixin _CreatePostViewMixin on State<CreatePostView> {
  late final TextEditingController _captionController;
  @override
  void initState() {
    _captionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  Future<void> _createPost(BuildContext context) async {
    final caption = _captionController.text;
    await context.read<CreatePostViewModel>().createPost(caption: caption);
    if (context.mounted) context.router.pop();
  }

  Future<void> _pickImage(BuildContext context) async {
    await context.read<CreatePostViewModel>().imagePick();
  }
}
