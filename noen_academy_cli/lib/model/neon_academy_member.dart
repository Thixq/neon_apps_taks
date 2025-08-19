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
    this.motivationLevel,
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
      print("Bu üyenin motivasyon seviyesi belirlenmedi");
      return;
    }

    if (level > 5) {
      print("Bu üye oldukça motive olmuş durumda");
    } else {
      print("Bu üyenin motivasyon seviyesi: $level");
    }
  }

  String motivationStatus() {
    final level = motivationLevel;
    if (level == null || level == 0) {
      return "Hiç motive değil.";
    } else if (level > 5) {
      return "Aşırı motive.";
    } else {
      return "Motive.";
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
