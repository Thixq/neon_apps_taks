import 'package:admob/feature/admob/admob_award.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool isPremium = false;
  final adwardAd = AdmobRewarded(
    adUnitId: 'ca-app-pub-7174486298835059/8348971068',
  );

  @override
  void initState() {
    adwardAd.loadAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: InkWell(
        onTap: () {
          adwardAd.showAd(
            onRewarded: () {
              setState(() {
                isPremium = true;
              });
            },
          );
        },
        child: Center(
          child: Stack(
            children: [
              Container(height: 300, width: 300, color: Colors.blueAccent),
              Positioned(
                left: 0,
                right: 0,
                child: Visibility(
                  visible: isPremium,
                  child: Banner(
                    message: 'Premium',
                    location: BannerLocation.topEnd,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
