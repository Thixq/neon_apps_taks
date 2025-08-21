import 'package:flutter/material.dart';
import 'package:future_tech/components/controller_card.dart';
import 'package:future_tech/model/device_model.dart';
import 'package:future_tech/model/room_detail_model.dart';

class DetialView extends StatefulWidget {
  const DetialView({super.key, required this.roomDetail});

  final RoomDetailModel roomDetail;

  @override
  State<DetialView> createState() => _DetialViewState();
}

class _DetialViewState extends State<DetialView> {
  late final List<DeviceModel> mockDevices;

  @override
  void initState() {
    mockDevices = List.generate(
      widget.roomDetail.devicesIds!.length,
      (index) => DeviceModel.mock(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.roomDetail.title!)),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: ListView.separated(
          itemBuilder: (context, index) {
            final device = mockDevices[index];
            return ControllerCard(
              title: device.title!,
              process: device.process,
              turnOn: device.isTurnOn!,
            );
          },
          separatorBuilder: (context, index) => SizedBox(height: 16),
          itemCount: mockDevices.length,
        ),
      ),
    );
  }
}
