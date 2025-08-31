import 'package:flutter/material.dart';
import 'package:joh/feature/components/animeted_icon.dart';
import 'package:joh/feature/components/blur_image.dart';
import 'package:joh/feature/utils/dot_lottie_dedocer.dart';
import 'package:lottie/lottie.dart';

part 'home_mixin.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with TickerProviderStateMixin, _HomeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Old Pictures')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                BlurImage(
                  height: 300,
                  width: 300,
                  beginBlur: 50,
                  endBlur: 0,
                  controller: _controller,
                  imageUrl: 'https://cataas.com/cat',
                ),
                Visibility(
                  visible: _isLoading,
                  child: LottieBuilder.asset(
                    height: 150,
                    width: 150,
                    'assets/loading.lottie',
                    controller: _controller,
                    renderCache: RenderCache.raster,
                    decoder: (bytes) => customLottieDecoder(bytes),
                  ),
                ),
              ],
            ),
            AnimatedPlayPauseIcon(size: 64, onChanged: _decode),
          ],
        ),
      ),
    );
  }
}
