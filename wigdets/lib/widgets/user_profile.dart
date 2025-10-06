import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserProfileTask extends StatefulWidget {
  const UserProfileTask({super.key});

  @override
  State<UserProfileTask> createState() => _UserProfileTaskState();
}

class _UserProfileTaskState extends State<UserProfileTask> {
  final PageController _controller = PageController();
  File? _profileImage;
  final String _name = "Flutter Dev";
  int _age = 25;
  Color _bgColor = Colors.white;
  String _fontFamily = 'Roboto';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - _age),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _age = DateTime.now().year - picked.year;
      });
    }
  }

  void _pickColor(BuildContext context) async {
    Color tempColor = _bgColor; // Geçici renk değişkeni

    Color? pickedColor = await showDialog<Color>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Pick Background Color'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: _bgColor,
            onColorChanged: (color) =>
                tempColor = color, // tempColor güncelleniyor
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(
              context,
              tempColor,
            ), // Dialog kapatıldığında renk döndürülüyor
            child: const Text('OK'),
          ),
        ],
      ),
    );

    if (pickedColor != null) {
      setState(() {
        _bgColor = pickedColor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _bgColor,
      height: 400, // ListView içi için sabit height
      child: PageView(
        controller: _controller,
        children: [
          /// Sayfa 1: Profil
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : null,
                child: _profileImage == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              ),
              const SizedBox(height: 16),
              Text(
                _name,
                style: TextStyle(fontSize: 24, fontFamily: _fontFamily),
              ),
              Text('Age: $_age', style: TextStyle(fontSize: 18)),
            ],
          ),

          /// Sayfa 2: Fotoğraf seç
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Profile Image'),
              ),
            ],
          ),

          /// Sayfa 3: Font seç (Örnek basit)
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _fontFamily = _fontFamily == 'Roboto'
                        ? 'Courier'
                        : 'Roboto';
                  });
                },
                child: const Text('Toggle Font'),
              ),
            ],
          ),

          /// Sayfa 4: Yaş seç
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _pickDate(context),
                child: const Text('Pick Your Birth Date'),
              ),
              Text('Selected Age: $_age'),
            ],
          ),

          /// Sayfa 5: Arka plan rengi
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _pickColor(context),
                child: const Text('Pick Background Color'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
