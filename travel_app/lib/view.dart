import 'package:flutter/material.dart';
import 'package:travel_app/shared_pref.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final name = SharedPrefHelper.getString('location', defaultValue: 'Boş');
  final times = SharedPrefHelper.getInt('localion_times', defaultValue: 0);
  final isVisited = SharedPrefHelper.getBool(
    'location_isVisited',
    defaultValue: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_buildTextField(), _buildList()],
          ),
        ),
      ),
    );
  }

  Expanded _buildList() {
    return Expanded(
      child: ListView.builder(
        itemCount: [name].length,
        itemBuilder: (context, index) => Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            SharedPrefHelper.remove('location');
            SharedPrefHelper.remove('localion_times');
            SharedPrefHelper.remove('location_isVisited');
          },
          background: Container(color: Colors.red),
          child: ListTile(
            onTap: () {
              SharedPrefHelper.setInt('localion_times', 1);
              SharedPrefHelper.setBool('location_isVisited', true);
              setState(() {});
            },
            title: Text(name!),
            subtitle: Text('Daha önce $times kere ziyaret edildi.'),
            trailing: Icon(
              isVisited! ? Icons.check_box : Icons.check_box_outline_blank,
            ),
          ),
        ),
      ),
    );
  }

  TextField _buildTextField() => TextField(
    onSubmitted: (value) => setState(() {
      SharedPrefHelper.setString('location', value);
    }),
  );
}
