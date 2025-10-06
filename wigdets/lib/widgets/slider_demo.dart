import 'package:flutter/material.dart';

class SliderDemo extends StatefulWidget {
  const SliderDemo({super.key});

  @override
  State<SliderDemo> createState() => _SliderDemoState();
}

class _SliderDemoState extends State<SliderDemo> {
  double _sliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Minimum değer ikonu (yeşil ejderha)
            const Icon(
              Icons.local_fire_department_outlined,
              color: Colors.green,
              size: 40,
            ),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 6,
                  thumbColor: Colors.blue, // prenseslerin umudu
                  activeTrackColor: Colors.green,
                  inactiveTrackColor: Colors.red,
                  overlayColor: Colors.blue.withOpacity(0.2),
                  // Gradient için özel çizim
                  trackShape: GradientSliderTrack(),
                ),
                child: Slider(
                  value: _sliderValue,
                  min: 0,
                  max: 100,
                  divisions: 100, // 1'er artış
                  label: _sliderValue.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                    });
                  },
                ),
              ),
            ),
            // Maksimum değer ikonu (kırmızı ejderha)
            const Icon(
              Icons.local_fire_department,
              color: Colors.red,
              size: 40,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "Slider değeri: ${_sliderValue.round()}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

/// Slider track için gradient çizen özel şekil
class GradientSliderTrack extends SliderTrackShape {
  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    required RenderBox parentBox,
    Offset? secondaryOffset, // <-- nullable ve opsiyonel olmalı
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required Offset thumbCenter,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 6.0;

    final Rect trackRect = Rect.fromLTWH(
      offset.dx,
      offset.dy + (parentBox.size.height - trackHeight) / 2,
      parentBox.size.width,
      trackHeight,
    );

    final Paint paint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.green, Colors.red],
      ).createShader(trackRect);

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, const Radius.circular(4)),
      paint,
    );
  }

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight ?? 6.0;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;

    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
