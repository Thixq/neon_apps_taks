import 'dart:io';

import 'package:task1_neon_model/enum/horoscope.dart';
import 'package:task1_neon_model/enum/member_level.dart';
import 'package:task1_neon_model/enum/team.dart';
import 'package:task1_neon_model/functions/list_all_members.dart';
import 'package:task1_neon_model/model/neon_academy_member.dart';
import 'package:task1_neon_model/utils/prompts.dart';

void filterMember(List<NeonAcademyMember> members) {
  if (members.isEmpty) {
    print('Hiç üye yok.');
    return;
  }

  print('--- Filtreleme Seçenekleri ---');
  print('1. Member Level');
  print('2. Horoscope');
  print('3. Team');
  print('4. Title');
  print('5. Home Town');
  print('6. Yaş aralığı');
  stdout.write('Seçiminiz: ');
  final choice = stdin.readLineSync();

  Iterable<NeonAcademyMember> filtered = members;

  switch (choice) {
    case '1':
      final level = promptEnum<MemberLevel>(
        'Member Level seçiniz',
        MemberLevel.values,
      );
      filtered = members.where((m) => m.memberLevel == level);
      break;

    case '2':
      final horoscope = promptEnum<Horoscope>(
        'Horoscope seçiniz',
        Horoscope.values,
      );
      filtered = members.where((m) => m.horoscope == horoscope);
      break;

    case '3':
      final team = promptEnum<Team>('Team seçiniz', Team.values);
      filtered = members.where((m) => m.team == team);
      break;

    case '4':
      final title = prompt('Title giriniz: ');
      filtered = members.where(
        (m) => m.title.toLowerCase() == title.toLowerCase(),
      );
      break;

    case '5':
      final homeTown = prompt('Home Town giriniz: ');
      filtered = members.where(
        (m) => m.homeTown.toLowerCase() == homeTown.toLowerCase(),
      );
      break;

    case '6':
      final minAge = promptInt('Minimum yaş: ');
      final maxAge = promptInt('Maximum yaş: ');
      filtered = members.where((m) => m.age >= minAge && m.age <= maxAge);
      break;

    default:
      print('Geçersiz seçim.');
      return;
  }

  if (filtered.isEmpty) {
    print('\nHiç eşleşen üye bulunamadı.');
  } else {
    print('\n--- Filtrelenen Üyeler ---');
    listMembers(filtered);
  }
}
