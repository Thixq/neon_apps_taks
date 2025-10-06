import 'package:flutter/material.dart';

class Task13Widget extends StatefulWidget {
  const Task13Widget({super.key});

  @override
  State<Task13Widget> createState() => _Task13WidgetState();
}

class _Task13WidgetState extends State<Task13Widget> {
  final ScrollController _controller = ScrollController();

  List<Widget> items = List.generate(
    8,
    (index) => _label(
      "Label ${index + 1}",
      Colors.primaries[index % Colors.primaries.length],
    ),
  );
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        _fetchNewItem();
      }
    });
  }

  void _fetchNewItem() async {
    isLoading = true;
    setState(() {});
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        items.add(
          _label(
            "Label ${items.length + 1}",
            Colors.primaries[items.length % Colors.primaries.length],
          ),
        );
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // 2 ekran yüksekliği
      child: SingleChildScrollView(
        controller: _controller,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...items,
            isLoading
                ? const CircularProgressIndicator(color: Colors.red)
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

Widget _label(String text, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
