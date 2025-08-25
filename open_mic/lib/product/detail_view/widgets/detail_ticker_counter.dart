part of '../detail_view.dart';

class _DetailTickerCounter extends StatefulWidget {
  const _DetailTickerCounter(this.onChange);

  final ValueChanged<int> onChange;

  @override
  State<_DetailTickerCounter> createState() => _DetailTickerCounterState();
}

class _DetailTickerCounterState extends State<_DetailTickerCounter> {
  int _count = 1; // 1 kişiden başlasın

  void _increment() {
    setState(() {
      _count++;
      widget.onChange(_count);
    });
  }

  void _decrement() {
    setState(() {
      if (_count > 1) {
        _count--;
        widget.onChange(_count);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: _decrement,
          child: const Text("-1", style: TextStyle(fontSize: 20)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '$_count Kişi',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        TextButton(
          onPressed: _increment,
          child: const Text("+1", style: TextStyle(fontSize: 20)),
        ),
      ],
    );
  }
}
