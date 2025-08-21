import 'dart:convert';
import 'dart:math';

final class RoomDetailModel {
  final String? title;
  final String? iconString;
  final List<String>? devicesIds;
  final bool? isActiveRoom;

  const RoomDetailModel({
    this.title,
    this.iconString,
    this.devicesIds,
    this.isActiveRoom,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'iconString': iconString,
      'devicesIds': devicesIds,
      'isActiveRoom': isActiveRoom,
    };
  }

  factory RoomDetailModel.fromMap(Map<String, dynamic> map) {
    return RoomDetailModel(
      devicesIds: List<String>.from(map['devicesIds'] ?? []),
      iconString: map['iconString'],
      isActiveRoom: map['isActiveRoom'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomDetailModel.fromJson(String source) =>
      RoomDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  RoomDetailModel copyWith({
    String? title,
    String? iconString,
    List<String>? devicesIds,
    bool? isActiveRoom,
  }) {
    return RoomDetailModel(
      title: title ?? this.title,
      iconString: iconString ?? this.iconString,
      devicesIds: devicesIds ?? this.devicesIds,
      isActiveRoom: isActiveRoom ?? this.isActiveRoom,
    );
  }

  factory RoomDetailModel.mock() {
    final random = Random();
    final roomNames = ["Living Room", "Bedroom", "Kitchen", "Office", "Garage"];
    final icons = ["sofa", "bed", "kitchen", "computer", "car"];

    // Rastgele cihaz ID listesi oluştur
    final deviceCount = random.nextInt(5) + 1; // 1 ile 5 arası cihaz
    final devices = List.generate(
      deviceCount,
      (index) => "device_${random.nextInt(1000)}",
    );

    return RoomDetailModel(
      title: roomNames[random.nextInt(roomNames.length)],
      iconString: icons[random.nextInt(icons.length)],
      devicesIds: devices,
      isActiveRoom: random.nextBool(),
    );
  }
}
