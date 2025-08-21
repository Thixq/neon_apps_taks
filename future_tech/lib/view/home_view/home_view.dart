import 'package:flutter/material.dart';
import 'package:future_tech/components/room_card.dart';
import 'package:future_tech/model/room_detail_model.dart';
import 'package:future_tech/utils/ui/dialog/create_room_dialog/create_room_dialog.dart';
import 'package:future_tech/view/detail_view/detial_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<RoomDetailModel> rooms = [
    RoomDetailModel.mock(),
    RoomDetailModel.mock(),
    RoomDetailModel.mock(),
    RoomDetailModel.mock(),
    RoomDetailModel.mock(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final room = await CreateRoomDialog.showCreateRoomDialog(context);
          final newRoom = RoomDetailModel.mock();
          rooms.add(newRoom.copyWith(title: room?.title));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text('IoT Home - Future Tech')),
      body: Center(
        child: ListView.separated(
          itemCount: rooms.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final e = rooms[index];
            return RoomCard(
              isTurnOn: e.isActiveRoom ?? false,
              title: e.title ?? "Unknown",
              deviceCount: e.devicesIds?.length ?? 0,
              icon: Icons.home,
              onPressedCard: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetialView(roomDetail: rooms[index]),
                  ),
                );
              },
              onSwitch: (value) {
                setState(() {
                  rooms[index] = e.copyWith(isActiveRoom: value);
                });
              },
            );
          },
        ),
      ),
    );
  }
}
