part of 'home_view.dart';

// Mixin tanımını değiştirin
mixin _HomeMixin on State<HomeView>, TickerProviderStateMixin<HomeView> {
  late final AnimationController _controller;
  final _blurDuration = Duration(seconds: 10);
  bool _isLoading = false;

  void _decode(isPlaying) {
    if (isPlaying) {
      _controller.forward();
    } else {
      if (_controller.isCompleted) {
        _controller.reset();
      }
      _controller.stop();
    }
  }

  void _statusListener(status) {
    if (status.isAnimating) {
      setState(() {
        _isLoading = !_isLoading;
      });
    }
    if (status.isCompleted) {
      setState(() {
        _isLoading = !_isLoading;
      });
    }
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: _blurDuration);
    _controller.addStatusListener(_statusListener);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_statusListener);
    _controller.dispose();
    super.dispose();
  }
}
