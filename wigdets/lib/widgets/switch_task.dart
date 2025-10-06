import 'package:flutter/material.dart';

class SwitchTask extends StatefulWidget {
  const SwitchTask({super.key});

  @override
  State<SwitchTask> createState() => _SwitchTaskState();
}

class _SwitchTaskState extends State<SwitchTask> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isOn ? Colors.green : Colors.red, // ekranın rengi değişiyor
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Magical Switch - On/Off",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Switch(
            value: isOn,
            onChanged: (value) {
              setState(() {
                isOn = value;
              });
            },
            thumbColor: WidgetStateProperty.all(Colors.black),
            activeThumbColor: Colors.red, // açıkken switch rengi kırmızı
            inactiveThumbColor: Colors.black, // kapalıyken de siyah kalsın
            inactiveTrackColor: Colors.green, // kapalıyken switch yeşil
          ),
        ],
      ),
    );
  }
}
