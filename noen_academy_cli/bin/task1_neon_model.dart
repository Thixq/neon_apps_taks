import 'dart:io';
import 'package:task1_neon_model/functions/create_member.dart';
import 'package:task1_neon_model/functions/list_all_members.dart';
import 'package:task1_neon_model/neon_academy_member.dart';

void main() {
  final List<NeonAcademyMember> mainList = [];
  while (true) {
    print('\n--- Neon Academy CLI ---');
    print('1. Üye oluştur');
    print('2. Tüm üyeleri listele');
    print('3. Çıkış');
    stdout.write('Seçiminiz: ');
    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        createMember(mainList);
        break;
      case '2':
        listMembers(mainList);
        break;
      case '3':
        print('Programdan çıkılıyor...');
        return;
      default:
        print('Geçersiz seçim, tekrar deneyin.');
    }
  }
}
