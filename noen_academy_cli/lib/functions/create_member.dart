import 'package:task1_neon_model/enum/horoscope.dart';
import 'package:task1_neon_model/enum/member_level.dart';
import 'package:task1_neon_model/enum/team.dart';
import 'package:task1_neon_model/model/neon_academy_member.dart';
import 'package:task1_neon_model/utils/prompts.dart';

void createMember(List<NeonAcademyMember> members) {
  final fullName = prompt('Full Name: ');

  final team = promptEnum('Title: ', Team.values);
  final title = prompt('Title: ');

  final horoscope = promptEnum('Horoscope: ', Horoscope.values);

  final memberLevel = promptEnum('Member Level: ', MemberLevel.values);

  final homeTown = prompt('Home Town: ');

  final age = promptInt('Age: ');

  final email = prompt('Email: ');

  final phoneNumber = prompt('Phone Number: ');

  final member = NeonAcademyMember(
    fullName: fullName,
    team: team,
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
