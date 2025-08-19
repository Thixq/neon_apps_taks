import 'dart:io';
import 'package:task1_neon_model/functions/list_all_members.dart';
import 'package:task1_neon_model/model/neon_academy_member.dart';

void sortMembers(List<NeonAcademyMember> members) {
  if (members.isEmpty) {
    print('Hiç üye yok.');
    return;
  }

  List<NeonAcademyMember> users = [...members];

  print('--- Sıralama kriterleri ---');
  print('1. Ada göre');
  print('2. Yaşa göre');
  print('3. Title\'a göre');
  print('4. Team\'e göre');
  print('5. Horoscope\'a göre');
  print('6. Member Level\'a göre');
  print('7. Home Town\'a göre');
  stdout.write('Seçiminiz: ');
  final choice = stdin.readLineSync();

  Comparator<NeonAcademyMember>? comparator;

  switch (choice) {
    case '1':
      comparator = (a, b) => a.fullName.compareTo(b.fullName);
      break;
    case '2':
      comparator = (a, b) => a.age.compareTo(b.age);
      break;
    case '3':
      comparator = (a, b) => a.title.compareTo(b.title);
      break;
    case '4':
      comparator = (a, b) => a.team.name.compareTo(b.team.name);
      break;
    case '5':
      comparator = (a, b) => a.horoscope.name.compareTo(b.horoscope.name);
      break;
    case '6':
      comparator = (a, b) => a.memberLevel.name.compareTo(b.memberLevel.name);
      break;
    case '7':
      comparator = (a, b) => a.homeTown.compareTo(b.homeTown);
      break;
    default:
      print('Geçersiz seçim, sıralama yapılmadı.');
      return;
  }

  print('\nSıralama yönü:');
  print('1. Küçükten büyüğe (Ascending)');
  print('2. Büyükten küçüğe (Descending)');
  stdout.write('Seçiminiz: ');
  final directionChoice = stdin.readLineSync();

  bool asc = directionChoice != '2';

  users.sort(comparator);
  if (!asc) {
    users = users.reversed.toList();
  }

  print('\n--- Sıralama Sonucu ---');
  listMembers(users);
}
