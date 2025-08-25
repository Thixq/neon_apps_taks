import 'package:flutter/material.dart';

class PageAnimations {
  const PageAnimations._();

  static PageRouteBuilder pageRouteBuilderSlide(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        final offsetAnimation = Tween(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  static PageRouteBuilder pageRouteBuilderZoom(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        final slide = Tween(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation);
        final scale = Tween<double>(begin: 0.8, end: 1).animate(animation);
        return SlideTransition(
          position: slide,
          child: ScaleTransition(scale: scale, child: child),
        );
      },
    );
  }

  static PageRouteBuilder pageRouteBuilderPush(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        final slide = Tween(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(animation);
        return SlideTransition(position: slide, child: child);
      },
    );
  }

  static PageRouteBuilder pageRouteBuilderCover(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 600),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        final slide = Tween(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(animation);
        final fade = Tween<double>(begin: 0, end: 1).animate(animation);
        return FadeTransition(
          opacity: fade,
          child: SlideTransition(position: slide, child: child),
        );
      },
    );
  }
}
