// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:task1_neon_model/enum/horoscope.dart';
import 'package:task1_neon_model/enum/member_level.dart';
import 'package:task1_neon_model/enum/team.dart';

final class NeonAcademyMember {
  final String fullName;
  final Team team;
  final String title;
  final Horoscope horoscope;
  final MemberLevel memberLevel;
  final String homeTown;
  final int age;
  final ContactInformation contactInformation;

  const NeonAcademyMember({
    required this.fullName,
    required this.team,
    required this.title,
    required this.horoscope,
    required this.memberLevel,
    required this.homeTown,
    required this.age,
    required this.contactInformation,
  });

  @override
  String toString() {
    return 'NeonAcademyMember(fullName: $fullName, team: $team, title: $title, horoscope: $horoscope, memberLevel: $memberLevel, homeTown: $homeTown, age: $age, contactInformation: $contactInformation)';
  }
}

final class ContactInformation {
  final String email;
  final String phoneNumber;

  const ContactInformation({required this.email, required this.phoneNumber});

  @override
  String toString() =>
      'ContactInformation(email: $email, phoneNumber: $phoneNumber)';
}
