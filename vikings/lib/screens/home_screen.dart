import 'package:flutter/material.dart';
import '../widgets/invisibility_spell.dart';
import '../widgets/rotation_spell.dart';
import '../widgets/movement_spell.dart';
import '../widgets/size_spell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ulfr'un Animasyon Büyüleri"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            InvisibilitySpell(),
            SizedBox(height: 20),
            RotationSpell(),
            SizedBox(height: 20),
            MovementSpell(),
            SizedBox(height: 20),
            SizeSpell(),
          ],
        ),
      ),
    );
  }
}
