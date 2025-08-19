import 'package:task1_neon_model/model/neon_academy_member.dart';

void listMembers(Iterable<NeonAcademyMember> members) {
  if (members.isEmpty) {
    print('\nHenüz üye yok.');
    return;
  }

  print('\n--- Tüm Üyeler ---');
  int i = 0;
  for (var m in members) {
    print(
      '${i + 1}. ${m.fullName}, ${m.team.name}, ${m.title}, ${m.horoscope.name}, '
      '${m.memberLevel.name}, ${m.homeTown}, ${m.age} yaşında, '
      'Email: ${m.contactInformation.email}, '
      'Phone: ${m.contactInformation.phoneNumber}',
    );
    i++;
  }
}
