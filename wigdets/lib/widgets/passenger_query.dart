import 'package:flutter/material.dart';

// Passenger model
class Passenger {
  final String name;
  final String surname;
  final String team;
  final int age;
  final String hometown;
  final String email;

  Passenger({
    required this.name,
    required this.surname,
    required this.team,
    required this.age,
    required this.hometown,
    required this.email,
  });
}

// Örnek veri
final List<Passenger> passengers = [
  Passenger(
    name: 'Mini',
    surname: 'Mouse',
    team: 'Flutter',
    age: 25,
    hometown: 'Orlando',
    email: 'mini@academy.com',
  ),
  Passenger(
    name: 'Mickey',
    surname: 'Mouse',
    team: 'iOS',
    age: 28,
    hometown: 'Orlando',
    email: 'mickey@academy.com',
  ),
  Passenger(
    name: 'Donald',
    surname: 'Duck',
    team: 'Android',
    age: 22,
    hometown: 'LA',
    email: 'donald@academy.com',
  ),
  Passenger(
    name: 'Daisy',
    surname: 'Duck',
    team: 'Design',
    age: 26,
    hometown: 'NY',
    email: 'daisy@academy.com',
  ),
];

class DataTableSearchTask extends StatefulWidget {
  const DataTableSearchTask({super.key});

  @override
  State<DataTableSearchTask> createState() => _DataTableSearchTaskState();
}

class _DataTableSearchTaskState extends State<DataTableSearchTask> {
  String searchQuery = '';
  int selectedSegment = 0; // 0 -> Name, 1 -> Surname

  @override
  Widget build(BuildContext context) {
    // Filtreleme
    List<Passenger> filteredPassengers = passengers.where((p) {
      if (searchQuery.isEmpty) return true;
      if (selectedSegment == 0) {
        return p.name.toLowerCase().contains(searchQuery.toLowerCase());
      } else {
        return p.surname.toLowerCase().contains(searchQuery.toLowerCase());
      }
    }).toList();

    return Column(
      children: [
        // Arama çubuğu
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search...',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value;
              });
            },
          ),
        ),
        // Segmented control
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            width: 250,
            child: SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 0, label: Text('Name')),
                ButtonSegment(value: 1, label: Text('Surname')),
              ],
              selected: <int>{selectedSegment},
              onSelectionChanged: (newSelection) {
                setState(() {
                  selectedSegment = newSelection.first;
                });
              },
            ),
          ),
        ),
        // DataTable
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Surname')),
              DataColumn(label: Text('Team')),
              DataColumn(label: Text('Age')),
              DataColumn(label: Text('Hometown')),
              DataColumn(label: Text('Email')),
            ],
            rows: filteredPassengers.map((p) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(p.name),
                    onTap: () => _navigateToDetail(context, p),
                  ),
                  DataCell(
                    Text(p.surname),
                    onTap: () => _navigateToDetail(context, p),
                  ),
                  DataCell(
                    Text(p.team),
                    onTap: () => _navigateToDetail(context, p),
                  ),
                  DataCell(
                    Text(p.age.toString()),
                    onTap: () => _navigateToDetail(context, p),
                  ),
                  DataCell(
                    Text(p.hometown),
                    onTap: () => _navigateToDetail(context, p),
                  ),
                  DataCell(
                    Text(p.email),
                    onTap: () => _navigateToDetail(context, p),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _navigateToDetail(BuildContext context, Passenger passenger) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PassengerDetailPage(passenger: passenger),
      ),
    );
  }
}

// Detay sayfası
class PassengerDetailPage extends StatelessWidget {
  final Passenger passenger;
  const PassengerDetailPage({super.key, required this.passenger});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Passenger Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${passenger.name}'),
            Text('Surname: ${passenger.surname}'),
            Text('Team: ${passenger.team}'),
            Text('Age: ${passenger.age}'),
            Text('Hometown: ${passenger.hometown}'),
            Text('Email: ${passenger.email}'),
          ],
        ),
      ),
    );
  }
}
