import 'package:adapty/feature/alerts/new_note_dialog.dart';
import 'package:adapty/feature/alerts/offer_bottom_sheet.dart';
import 'package:adapty/feature/components/note_card.dart';
import 'package:adapty/feature/components/profile_avatar.dart';
import 'package:adapty/feature/constant/payment.dart';
import 'package:adapty/feature/models/note_model.dart';
import 'package:adapty/feature/profile/profile.dart';
import 'package:adapty/feature/services/payment_service.dart';
import 'package:adapty/feature/services/subscription_local_sync_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pay/pay.dart';

part 'home_mixin.dart';
part './widget/profile.dart';
part './widget/todo_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with _HomeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _profile.subscriptionInfo.isActiveSubscription
            ? _addNote
            : null,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 16,
        centerTitle: false,
        title: _Profile(
          profile: _profile,
          offterOnPressed: () {
            OfferBottomSheet.show(context, plus: _plus);
          },
          profileOnPressed: () {},
        ),
      ),
      body: _buildNotes(),
    );
  }

  Padding _buildNotes() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: _TodoList(notes: _mainList),
    );
  }
}
