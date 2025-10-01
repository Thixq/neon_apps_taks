class Person {
  final int? id;
  final String name;
  final String surname;
  final int age;
  final String email;

  Person({
    this.id,
    required this.name,
    required this.surname,
    required this.age,
    required this.email,
  });

  // JSON → Person
  factory Person.fromMap(Map<String, dynamic> json) => Person(
    id: json['id'],
    name: json['name'],
    surname: json['surname'],
    age: json['age'],
    email: json['email'],
  );

  // Person → JSON
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'surname': surname,
    'age': age,
    'email': email,
  };
}
