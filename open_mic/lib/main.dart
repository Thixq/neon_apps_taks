import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_mic/feature/service/mock_network.dart';
import 'package:open_mic/product/detail_view/detail_view.dart';
import 'package:open_mic/product/home_view/home_view.dart';
import 'package:open_mic/product/home_view/view_model/home_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeViewModel(mockNetwork: MockNetwork()),
      child: MaterialApp(
        title: 'Open Mic',
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeView(),
          '/detail': (context) => const DetailView(),
        },
      ),
    );
  }
}
