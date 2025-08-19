import 'package:task1_neon_model/model/neon_academy_member.dart';
import 'package:task1_neon_model/utils/prompts.dart';

void deleteMember(List<NeonAcademyMember> members) {
  if (members.isEmpty) {
    print('\nHiç üye yok, silme işlemi yapılamaz.');
    return;
  }

  print('--- Silme Kriterleri ---');
  print('1. Index\'e göre sil');
  print('2. Ada göre sil');
  print('3. Takıma göre sil');
  final choice = prompt('Seçiminiz: ');

  switch (choice) {
    case '1': // indexe göre silme
      final index = promptInt('Silmek istediğiniz kişinin sırasını yazın:');
      if (index <= 0 || index > members.length) {
        print('\nHata: Geçersiz index!');
        return;
      }
      final removed = members.removeAt(index - 1);
      print('\n${removed.fullName} üye silindi.');
      break;

    case '2': // ada göre silme
      final name = prompt('Silmek istediğiniz kişinin adını yazın:');
      final match = members.indexWhere(
        (m) => m.fullName.toLowerCase() == name.toLowerCase(),
      );
      if (match == -1) {
        print('\nHata: Böyle bir üye bulunamadı!');
        return;
      }
      final removed = members.removeAt(match);
      print('\n${removed.fullName} üye silindi.');
      break;

    case '3': // takıma göre silme
      final teamName = prompt('Silmek istediğiniz takımın adını yazın: ');
      final toRemove = members
          .where((m) => m.team.name.toLowerCase() == teamName.toLowerCase())
          .toList();

      if (toRemove.isEmpty) {
        print('\nHata: Bu takıma ait üye bulunamadı!');
        return;
      }

      members.removeWhere(
        (m) => m.team.name.toLowerCase() == teamName.toLowerCase(),
      );

      print('\n${toRemove.length} üye $teamName takımından silindi.');
      break;

    default:
      print('\nGeçersiz seçim, silme işlemi yapılmadı.');
  }
}
