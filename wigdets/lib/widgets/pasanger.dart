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

// Örnek veriler
final List<Passenger> passengers = [
  Passenger(
    name: 'Alice',
    surname: 'Smith',
    team: 'Flutter',
    age: 25,
    hometown: 'NY',
    email: 'alice@flutter.com',
  ),
  Passenger(
    name: 'Bob',
    surname: 'Johnson',
    team: 'iOS',
    age: 28,
    hometown: 'LA',
    email: 'bob@ios.com',
  ),
  Passenger(
    name: 'Charlie',
    surname: 'Brown',
    team: 'Android',
    age: 22,
    hometown: 'Chicago',
    email: 'charlie@android.com',
  ),
  Passenger(
    name: 'Daisy',
    surname: 'Miller',
    team: 'Design',
    age: 26,
    hometown: 'Miami',
    email: 'daisy@design.com',
  ),
  // Daha fazla örnek ekleyebilirsin
];

class DataTableTask extends StatelessWidget {
  const DataTableTask({super.key});

  @override
  Widget build(BuildContext context) {
    // Takım bazlı filtreleme
    final Map<String, List<Passenger>> teamMap = {
      'Flutter Team': passengers.where((p) => p.team == 'Flutter').toList(),
      'iOS Team': passengers.where((p) => p.team == 'iOS').toList(),
      'Android Team': passengers.where((p) => p.team == 'Android').toList(),
      'Design Team': passengers.where((p) => p.team == 'Design').toList(),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: teamMap.entries.map((entry) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                entry.key,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Surname')),
                  DataColumn(label: Text('Age')),
                  DataColumn(label: Text('Hometown')),
                  DataColumn(label: Text('Email')),
                ],
                rows: entry.value.map((passenger) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(passenger.name),
                        onTap: () => _navigateToDetail(context, passenger),
                      ),
                      DataCell(
                        Text(passenger.surname),
                        onTap: () => _navigateToDetail(context, passenger),
                      ),
                      DataCell(
                        Text(passenger.age.toString()),
                        onTap: () => _navigateToDetail(context, passenger),
                      ),
                      DataCell(
                        Text(passenger.hometown),
                        onTap: () => _navigateToDetail(context, passenger),
                      ),
                      DataCell(
                        Text(passenger.email),
                        onTap: () => _navigateToDetail(context, passenger),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      }).toList(),
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
