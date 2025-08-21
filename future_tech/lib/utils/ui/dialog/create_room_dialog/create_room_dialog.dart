import 'package:flutter/material.dart';
import 'package:future_tech/model/room_model.dart';

part './widget/actions.dart';
part './widget/grid_icon_selector.dart';
part './widget/title.dart';

class CreateRoomDialog {
  const CreateRoomDialog._();

  static Future<RoomModel?> showCreateRoomDialog(BuildContext context) async {
    RoomModel room = RoomModel();

    return showDialog<RoomModel>(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _Title(
                  onSubmitted: (value) {
                    room = room.copyWith(title: value);
                  },
                ),
                Flexible(
                  child: _GridIconSelector(
                    onChanged: (icon) {
                      room = room.copyWith(icon: icon);
                    },
                  ),
                ),
                _Actions(
                  isDoneAction: () {
                    Navigator.of(context).pop(room);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
