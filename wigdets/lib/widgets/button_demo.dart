import 'package:flutter/material.dart';

class ButtonDemo extends StatelessWidget {
  const ButtonDemo({super.key});

  void _showDailySpecials(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Günün Spesiyalleri"),
        content: const Text(
          "🥩 Izgara biftek\n🍷 Kırmızı şarap\n🥧 Elmalı turta",
        ),
        actions: [
          TextButton(
            child: const Text("Kapat"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => _showDailySpecials(context),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 220,
          height: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            // Gradient + renk
            gradient: LinearGradient(
              colors: [Colors.red.withOpacity(0.5), Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue, width: 2),
            // Drop shadow
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(2, 4),
              ),
            ],
            // Arka plan resmi
            image: const DecorationImage(
              image: NetworkImage("https://picsum.photos/200/300"),
              fit: BoxFit.cover,
              opacity: 0.6, // gradient üstüne otursun
            ),
          ),
          child: const Text(
            "Günün Spesiyali",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.black45,
                  offset: Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
