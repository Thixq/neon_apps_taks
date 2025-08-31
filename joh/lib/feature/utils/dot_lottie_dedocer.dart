import 'dart:convert';
import 'dart:typed_data';

import 'package:lottie/lottie.dart';

Future<LottieComposition?> customLottieDecoder(List<int> bytes) {
  return LottieComposition.decodeZip(
    Uint8List.fromList(bytes),
    filePicker: (files) {
      final manifestFile = files.firstWhere(
        (file) => file.name.endsWith('manifest.json'),
        orElse: () => throw Exception('manifest.json dosyası bulunamadı.'),
      );

      final manifestBytes = manifestFile.readBytes()!.toList();
      final manifestJson = json.decode(utf8.decode(manifestBytes));

      final animations = manifestJson['animations'] as List<dynamic>;
      if (animations.isEmpty) {
        throw Exception('Manifestte animasyon bulunamadı.');
      }
      final animationId = animations.first['id'] as String;

      final animationFileName = 'animations/$animationId.json';
      final animationFile = files.firstWhere(
        (file) => file.name == animationFileName,
        orElse: () => throw Exception('$animationFileName dosyası bulunamadı.'),
      );

      return animationFile;
    },
  );
}
