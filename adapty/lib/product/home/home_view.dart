import 'package:adapty/feature/bottom_sheets/offer_bottom_sheet.dart';
import 'package:adapty/feature/components/profile_avatar.dart';
import 'package:adapty/feature/constant/image.dart';
import 'package:flutter/material.dart';

part './widget/profile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: _Profile(
          offterOnPressed: () {
            OfferBottomSheet.show(
              context,
              standard: () {},
              plus: () {},
              ultimate: () {},
            );
          },
          profileOnPressed: () {},
        ),
      ),
      body: Center(
        child: ProfileAvatar(onPressed: () {}, imageUrl: ImageConst.profile),
      ),
    );
  }
}
