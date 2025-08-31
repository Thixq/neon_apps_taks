import 'package:flutter/material.dart';

class AnimatedPlayPauseIcon extends StatefulWidget {
  final ValueChanged<bool>? onChanged;
  final Duration duration;
  final AnimatedIconData icon;
  final double? size;

  const AnimatedPlayPauseIcon({
    super.key,
    this.onChanged,
    this.duration = const Duration(milliseconds: 500),
    this.icon = AnimatedIcons.play_pause,
    this.size = 24,
  });

  @override
  State<AnimatedPlayPauseIcon> createState() => _AnimatedPlayPauseIconState();
}

class _AnimatedPlayPauseIconState extends State<AnimatedPlayPauseIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isPlaying = false;

  void _handleOnPressed() {
    setState(() {
      if (_isPlaying) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      _isPlaying = !_isPlaying;
      widget.onChanged?.call(_isPlaying);
    });
  }

  @override
  void initState() {
    _controller = AnimationController(duration: widget.duration, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _handleOnPressed,
      icon: AnimatedIcon(
        size: widget.size,
        icon: widget.icon,
        progress: _controller,
      ),
    );
  }
}
