import 'dart:io';
import 'package:task1_neon_model/model/neon_academy_member.dart';

void showMemberMenu(NeonAcademyMember member) {
  while (true) {
    print('\n--- Kullanıcı Bilgileri ---');
    print(member);
    print('\n1. Motivasyonu artır');
    print('2. Motivasyon durumunu yazdır');
    print('3. Motivasyon seviyesini öğren');
    print('4. Ana menüye dön');
    stdout.write('Seçiminiz: ');
    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write("Artış miktarını girin: ");
        final input = stdin.readLineSync();
        final increase = int.tryParse(input ?? "") ?? 1;
        member.increaseMotivation(increase);
        print("Motivasyon güncellendi → ${member.motivationLevel}");
        break;
      case '2':
        member.printMotivationMessage();
        break;
      case '3':
        print("Durum: ${member.motivationStatus()}");
        break;
      case '4':
        return; // ana menüye dön
      default:
        print("Geçersiz seçim!");
    }
  }
}
