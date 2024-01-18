import 'dart:convert';

Person personFromMap(String str) => Person.fromMap(json.decode(str));

Person personFromJson(String str) {
  return Person.fromJson(json.decode(str));
}

String personToMap(Person data) => json.encode(data.toMap());

class Person {
  final String name;
  final List<String> friends;
  final Profession profession;

  Person({
    required this.name,
    required this.friends,
    required this.profession,
  });

  factory Person.fromMap(Map<String, dynamic> json) => Person(
    name: json["name"],
    friends: List<String>.from(json["friends"].map((x) => x)),
    profession: Profession.fromMap(json["profession"]),
  );

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    name: json["name"],
    friends: List<String>.from(json["friends"].map((x) => x)),
    profession: Profession.fromMap(json["profession"]),
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "friends": List<dynamic>.from(friends.map((x) => x)),
    "profession": profession.toMap(),
  };
}

class Profession {
  final String type;
  final double salary;
  final List<String> companyBranches;

  Profession({
    required this.type,
    required this.salary,
    required this.companyBranches,
  });

  factory Profession.fromMap(Map<String, dynamic> json) => Profession(
    type: json["type"],
    salary: json["salary"]?.toDouble(),
    companyBranches: List<String>.from(json["companyBranches"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "type": type,
    "salary": salary,
    "companyBranches": List<dynamic>.from(companyBranches.map((x) => x)),
  };
}
