import 'dart:ui';
import 'package:flutter/material.dart';

class BlurImage extends StatefulWidget {
  final String imageUrl;
  final AnimationController controller;
  final double beginBlur;
  final double endBlur;
  final BoxFit fit;
  final double? width;
  final double? height;

  const BlurImage({
    super.key,
    required this.imageUrl,
    required this.controller,
    this.beginBlur = 100,
    this.endBlur = 0,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  @override
  State<BlurImage> createState() => _BlurImageState();
}

class _BlurImageState extends State<BlurImage> {
  late Animation<double> _blurAnimation;

  @override
  void initState() {
    super.initState();

    _blurAnimation = Tween<double>(begin: widget.beginBlur, end: widget.endBlur)
        .animate(
          CurvedAnimation(parent: widget.controller, curve: Curves.easeInOut),
        );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _blurAnimation,
      builder: (context, child) {
        return ClipRect(
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: _blurAnimation.value,
              sigmaY: _blurAnimation.value,
            ),
            child: child,
          ),
        );
      },
      child: Image.network(
        widget.imageUrl,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
      ),
    );
  }
}
