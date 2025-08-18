import 'dart:io';
import 'package:task1_neon_model/enum/horoscope.dart';
import 'package:task1_neon_model/enum/member_level.dart';
import 'package:task1_neon_model/neon_academy_member.dart';

final List<NeonAcademyMember> members = [];

void main() {
  while (true) {
    print('\n--- Neon Academy CLI ---');
    print('1. Üye oluştur');
    print('2. Tüm üyeleri listele');
    print('3. Çıkış');
    stdout.write('Seçiminiz: ');
    final choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        createMember();
        break;
      case '2':
        listMembers();
        break;
      case '3':
        print('Programdan çıkılıyor...');
        return;
      default:
        print('Geçersiz seçim, tekrar deneyin.');
    }
  }
}

void createMember() {
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

void listMembers() {
  if (members.isEmpty) {
    print('\nHenüz üye yok.');
    return;
  }

  print('\n--- Tüm Üyeler ---');
  for (var i = 0; i < members.length; i++) {
    final m = members[i];
    print(
      '${i + 1}. ${m.fullName}, ${m.title}, ${m.horoscope.name}, '
      '${m.memberLevel.name}, ${m.homeTown}, ${m.age} yaşında, '
      'Email: ${m.contactInformation.email}, '
      'Phone: ${m.contactInformation.phoneNumber}',
    );
  }
}
