import 'package:flutter/material.dart';

class Task14Widget extends StatelessWidget {
  const Task14Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min, // Burayı ekledik
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicator: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              tabs: const [
                Tab(icon: Icon(Icons.home), text: 'Home'),
                Tab(icon: Icon(Icons.search), text: 'Search'),
                Tab(icon: Icon(Icons.favorite), text: 'Likes'),
                Tab(icon: Icon(Icons.person), text: 'Profile'),
              ],
            ),
          ),
          const SizedBox(height: 12),

          /// Burada Expanded yerine Flexible(fit: FlexFit.loose) kullanıyoruz
          Flexible(
            fit: FlexFit.loose,
            child: SizedBox(
              height:
                  200, // sabit yükseklik verdik, ListView içinde hata çıkmaz
              child: TabBarView(
                children: [
                  Container(color: Colors.redAccent),
                  Container(color: Colors.greenAccent),
                  Container(color: Colors.orangeAccent),
                  Container(color: Colors.purpleAccent),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
