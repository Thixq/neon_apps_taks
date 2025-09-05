import 'package:clone_insta/feature/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_preview_model.g.dart';

@JsonSerializable()
/// The model for a post preview.
final class PostPreviewModel extends BaseModel<PostPreviewModel> {
  /// Constructor for PostPreviewModel.
  PostPreviewModel({required super.id, this.imagePath});

  /// Creates a PostPreviewModel from a JSON map.
  factory PostPreviewModel.fromJson(Map<String, dynamic> json) =>
      _$PostPreviewModelFromJson(json);

  factory PostPreviewModel.mock() => PostPreviewModel(
    id: '1',
    imagePath:
        'https://cache.desktopnexus.com/thumbseg/2480/2480736-bigthumbnail.jpg',
  );

  /// The image path of the post preview.
  final String? imagePath;

  @override
  PostPreviewModel fromJson(Map<String, dynamic> json) =>
      _$PostPreviewModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PostPreviewModelToJson(this);
}
