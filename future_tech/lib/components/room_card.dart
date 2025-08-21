import 'package:flutter/material.dart';

class RoomCard extends StatefulWidget {
  const RoomCard({
    super.key,
    required this.isTurnOn,
    required this.title,
    required this.deviceCount,
    required this.icon,
    required this.onPressedCard,
    required this.onSwitch,
  });

  final bool isTurnOn;
  final String title;
  final int deviceCount;
  final IconData icon;
  final VoidCallback onPressedCard;
  final ValueChanged<bool> onSwitch;

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  late bool turnOn;

  @override
  void initState() {
    turnOn = widget.isTurnOn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: widget.onPressedCard,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.all(8),
      ),
      child: ListTile(
        leading: Icon(widget.icon, size: 32),
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text('${widget.deviceCount} devices'),
        trailing: Switch(
          value: turnOn,
          onChanged: (value) {
            setState(() {
              widget.onSwitch(value);
              turnOn = value;
            });
          },
        ),
      ),
    );
  }
}
