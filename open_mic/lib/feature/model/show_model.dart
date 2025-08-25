// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:open_mic/feature/constants/assets_const.dart';
import 'package:open_mic/feature/model/base_model.dart';
import 'package:open_mic/feature/utils/enums/show_category.dart';

final class ShowModel extends BaseModel<ShowModel> {
  final String? id;
  final String? name;
  final String? desc;
  final String? image;
  final ShowCategory? category;

  ShowModel({
    this.id,
    this.name,
    this.desc,
    this.image,
    this.category,
    super.responseStatus,
  });

  /// Random mock data factory
  factory ShowModel.mock() {
    final random = Random();
    final categories = ShowCategory.values;

    // Asset listesini hazırladık
    const assetImages = [
      AssetsConst.openMicOne,
      AssetsConst.openMicTwo,
      AssetsConst.openMicThree,
      AssetsConst.openMicFour,
      AssetsConst.openMicFive,
      AssetsConst.openMicSix,
      AssetsConst.openMicSeven,
      AssetsConst.openMicEight,
    ];

    return ShowModel(
      id: random.nextInt(1000).toString(),
      name: "Show #${random.nextInt(99)}",
      desc: "This is a random mock show description. ",
      image: assetImages[random.nextInt(assetImages.length)],
      category: categories[random.nextInt(categories.length)],
      responseStatus: "success",
    );
  }

  @override
  String toString() {
    return 'ShowModel(id: $id, name: $name, desc: $desc, image: $image, category: $category)';
  }
}
