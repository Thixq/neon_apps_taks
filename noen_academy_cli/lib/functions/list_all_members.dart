import 'package:task1_neon_model/neon_academy_member.dart';

void listMembers(List<NeonAcademyMember> members) {
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
