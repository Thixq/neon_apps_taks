import 'package:flutter/material.dart';
import 'package:open_mic/feature/model/base_model.dart';
import 'package:open_mic/feature/model/show_model.dart';

class MockNetwork {
  Future<T?> get<T extends BaseModel<T>>({
    required String url,
    required T castModel,
  }) async {
    try {
      if (url.trim().isEmpty || url != 'https://neonacademy/shows') {
        throw Exception('Wrong Url');
      }
      if (castModel.runtimeType == ShowModel) {
        return ShowModel.mock() as T;
      }
      throw Exception('Wrong');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
