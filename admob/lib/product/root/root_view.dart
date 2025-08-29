import 'package:admob/feature/admob/admob_interstitial.dart';
import 'package:admob/product/home/home_view.dart';
import 'package:admob/product/profile/profile_view.dart';
import 'package:flutter/material.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  int currentIndex = 0;

  final interstitial = AdmobInterstitial(
    adUnitId: 'ca-app-pub-7174486298835059/5011527135',
  );

  final pages = [HomeView(), ProfileView()];

  void onChange(int value) {
    setState(() {
      currentIndex = value;
      if (value == 1) {
        interstitial.showAd();
      }
    });
  }

  @override
  void initState() {
    interstitial.loadAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onChange,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Proifle'),
        ],
      ),
    );
  }
}
