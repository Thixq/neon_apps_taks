import 'package:admob/feature/admob/admob_banner.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final demoBanner = AdmobBanner(
    adUnitId: 'ca-app-pub-7174486298835059/8998055361',
  );

  @override
  void initState() {
    demoBanner.loadAd();
    super.initState();
  }

  @override
  void dispose() {
    demoBanner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      bottomNavigationBar: demoBanner.viewBanner(),
    );
  }
}
