// ignore_for_file: public_member_api_docs, sort_constructors_first, document_ignores

/// Post update model
class PostUpdateModel {
  /// Post update model
  const PostUpdateModel({
    this.caption,
  });

  /// Caption
  final String? caption;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'caption': caption,
    };
  }

  factory PostUpdateModel.fromMap(Map<String, dynamic> map) {
    return PostUpdateModel(
      caption: map['caption'] != null ? map['caption'] as String : null,
    );
  }
}
