part of 'create_post_view.dart';

mixin _CreatePostViewMixin on State<CreatePostView> {
  late final HLImagePickerIOS _picker;
  HLPickerItem? _pickedItem;

  @override
  void initState() {
    _picker = HLImagePickerIOS();
    _pick();
    super.initState();
  }

  void _onImagePicked(HLPickerItem item) {
    setState(() {
      _pickedItem = item;
    });
  }

  Future<void> _pick() async {
    try {
      final result = await _picker.openPicker(
        pickerOptions: const HLPickerOptions(
          maxSelectedAssets: 1,
          usedCameraButton: true,
          mediaType: MediaType.image,
          compressQuality: 50,
          convertLivePhotosToJPG: true,
        ),

        cropping: true,
      );
      _onImagePicked(result.first);
    } on PlatformException catch (error, stackTrace) {
      debugPrintStack(
        label: 'error.code: ${error.code} \n error.message: ${error.message}',
        stackTrace: stackTrace,
      );
    }
  }
}
