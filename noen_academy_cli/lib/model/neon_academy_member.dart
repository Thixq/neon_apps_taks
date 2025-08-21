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

  /// Yeni eklenen property: motivationLevel
  int? motivationLevel;

  NeonAcademyMember({
    required this.fullName,
    required this.team,
    required this.title,
    required this.horoscope,
    required this.memberLevel,
    required this.homeTown,
    required this.age,
    required this.contactInformation,
    this.motivationLevel, // opsiyonel başlatma
  });

  void increaseMotivation(int value) {
    if (motivationLevel == null) {
      motivationLevel = 1;
    } else {
      motivationLevel = motivationLevel! + value;
    }
  }

  void printMotivationMessage() {
    final level = motivationLevel;
    if (level == null) {
      print("This member has no motivation level set");
      return;
    }

    if (level > 5) {
      print("This member is highly motivated");
    } else {
      print("This member has motivation level: $level");
    }
  }

  String motivationStatus() {
    final level = motivationLevel;
    if (level == null || level == 0) {
      return "not motivated at all";
    } else if (level > 5) {
      return "highly motivated";
    } else {
      return "moderately motivated";
    }
  }

  int getMotivationOrZero() {
    return motivationLevel ?? 0;
  }

  bool hasReachedMotivation(int target) {
    final level = motivationLevel;
    if (level != null) {
      return level >= target;
    }
    return false;
  }

  @override
  String toString() {
    return 'NeonAcademyMember(fullName: $fullName, team: $team, title: $title, horoscope: $horoscope, memberLevel: $memberLevel, homeTown: $homeTown, age: $age, contactInformation: $contactInformation, motivationLevel: $motivationLevel)';
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
