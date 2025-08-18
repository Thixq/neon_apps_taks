import 'dart:io';

import 'package:task1_neon_model/enum/horoscope.dart';
import 'package:task1_neon_model/enum/member_level.dart';
import 'package:task1_neon_model/neon_academy_member.dart';

void createMember(List<NeonAcademyMember> members) {
  stdout.write('Full Name: ');
  final fullName = stdin.readLineSync() ?? '';

  stdout.write('Title: ');
  final title = stdin.readLineSync() ?? '';

  stdout.write('Horoscope (e.g., aries, taurus): ');
  final horoscopeInput = stdin.readLineSync() ?? '';
  final horoscope = Horoscope.values.firstWhere(
    (h) => h.name.toLowerCase() == horoscopeInput.toLowerCase(),
    orElse: () => Horoscope.aries,
  );

  stdout.write('Member Level (e.g., a1, a2, a3): ');
  final levelInput = stdin.readLineSync() ?? '';
  final memberLevel = MemberLevel.values.firstWhere(
    (l) => l.name.toLowerCase() == levelInput.toLowerCase(),
    orElse: () => MemberLevel.a1,
  );

  stdout.write('Home Town: ');
  final homeTown = stdin.readLineSync() ?? '';

  stdout.write('Age: ');
  final age = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

  stdout.write('Email: ');
  final email = stdin.readLineSync() ?? '';

  stdout.write('Phone Number: ');
  final phoneNumber = stdin.readLineSync() ?? '';

  final member = NeonAcademyMember(
    fullName: fullName,
    title: title,
    horoscope: horoscope,
    memberLevel: memberLevel,
    homeTown: homeTown,
    age: age,
    contactInformation: ContactInformation(
      email: email,
      phoneNumber: phoneNumber,
    ),
  );

  members.add(member);
  print('\nÜye başarıyla oluşturuldu!');
}
