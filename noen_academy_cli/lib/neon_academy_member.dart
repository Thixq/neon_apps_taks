import 'package:task1_neon_model/enum/horoscope.dart';
import 'package:task1_neon_model/enum/member_level.dart';

final class NeonAcademyMember {
  final String fullName;
  final String title;
  final Horoscope horoscope;
  final MemberLevel memberLevel;
  final String homeTown;
  final int age;
  final ContactInformation contactInformation;

  const NeonAcademyMember({
    required this.fullName,
    required this.title,
    required this.horoscope,
    required this.memberLevel,
    required this.homeTown,
    required this.age,
    required this.contactInformation,
  });
}

final class ContactInformation {
  final String email;
  final String phoneNumber;

  const ContactInformation({required this.email, required this.phoneNumber});
}
