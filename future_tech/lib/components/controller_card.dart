import 'package:flutter/material.dart';

class ControllerCard extends StatefulWidget {
  const ControllerCard({
    super.key,
    this.turnOn = false,
    this.process = 0,
    required this.title,
  });

  final bool turnOn;
  final double process;
  final String title;

  @override
  State<ControllerCard> createState() => _ControllerCardState();
}

class _ControllerCardState extends State<ControllerCard> {
  late bool turnOn;
  late double process;

  @override
  void initState() {
    turnOn = widget.turnOn;
    process = widget.process;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      padding: EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.light, size: 64),
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Slider(
                  // ignore: deprecated_member_use
                  year2023: false,
                  divisions: 10,
                  value: process,
                  onChanged: (value) {
                    setState(() {
                      process = value;
                    });
                  },
                ),
              ),
              Switch(
                value: turnOn,
                onChanged: (value) {
                  setState(() {
                    turnOn = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
