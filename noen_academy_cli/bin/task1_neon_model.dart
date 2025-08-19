import 'dart:io';
import 'package:task1_neon_model/enum/horoscope.dart';
import 'package:task1_neon_model/enum/member_level.dart';
import 'package:task1_neon_model/enum/team.dart';
import 'package:task1_neon_model/functions/create_member.dart';
import 'package:task1_neon_model/functions/delete_member.dart';
import 'package:task1_neon_model/functions/filter_member.dart';
import 'package:task1_neon_model/functions/list_all_members.dart';
import 'package:task1_neon_model/functions/sort_members.dart';
import 'package:task1_neon_model/functions/member_menu.dart'; // ✅ yeni eklenen import
import 'package:task1_neon_model/model/neon_academy_member.dart';
import 'package:task1_neon_model/utils/prompts.dart';

void main() {
  final List<NeonAcademyMember> mainList = List.generate(
    5,
    (index) => NeonAcademyMember(
      fullName: '${index + 1}',
      title: 'Developer',
      team: Team.android,
      horoscope: Horoscope.aries,
      memberLevel: MemberLevel.a1,
      homeTown: 'İstanbul',
      age: index + 20,
      contactInformation: ContactInformation(
        email: 'email${index + 1}@mail.com',
        phoneNumber: '05${index}1234567',
      ),
    ),
  );

  while (true) {
    print('\n--- Neon Academy CLI ---');
    print('1. Üye oluştur');
    print('2. Tüm üyeleri listele');
    print('3. Seçilen kişiyi sil');
    print('4. Sırala');
    print('5. Filtrele');
    print('6. Kullanıcı bilgileri');
    print('7. Çıkış');
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
        deleteMember(mainList);
        break;
      case '4':
        sortMembers(mainList);
        break;
      case '5':
        filterMember(mainList);
        break;
      case '6':
        if (mainList.isEmpty) {
          print("Henüz hiç üye yok.");
          break;
        }
        listMembers(mainList);
        final index = promptInt(
          'Detaylarını görmek istediğiniz üyenin index numarasını girin:',
        );
        if (index < 0 || index >= mainList.length) {
          print("Geçersiz seçim!");
        } else {
          showMemberMenu(mainList[index - 1]);
        }
        break;
      case '7':
        return;
      default:
        print('\nGeçersiz seçim, tekrar deneyin.');
    }
  }
}
