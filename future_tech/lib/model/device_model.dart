import 'dart:math';

class DeviceModel {
  final String? title;
  final bool? isTurnOn;
  final double process;

  const DeviceModel(this.title, this.isTurnOn, this.process);

  static DeviceModel mock() {
    final random = Random();
    final deviceNames = ["Lamp", "Fan", "TV", "Heater", "Air Conditioner"];

    return DeviceModel(
      deviceNames[random.nextInt(deviceNames.length)],
      random.nextBool(),
      random.nextDouble() * 1,
    );
  }
}
