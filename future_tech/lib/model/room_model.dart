// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class RoomModel {
  final IconData icon;
  final String title;
  RoomModel({this.icon = Icons.home, this.title = 'New Room'});

  RoomModel copyWith({IconData? icon, String? title}) {
    return RoomModel(icon: icon ?? this.icon, title: title ?? this.title);
  }
}
