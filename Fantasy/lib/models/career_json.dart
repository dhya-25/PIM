// To parse this JSON data, do
//
//     final career = careerFromJson(jsonString);

import 'dart:convert';

List<Career> careerFromJson(String str) => List<Career>.from(json.decode(str).map((x) => Career.fromJson(x)));

String careerToJson(List<Career> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Career {
  Career({
    this.id,
    this.name,
    this.firstname,
    this.lastname,
    this.age,
    this.birth,
    this.nationality,
    this.height,
    this.weight,
    this.team,
    this.career,
  });

  int id;
  String name;
  String firstname;
  String lastname;
  int age;
  Birth birth;
  String nationality;
  String height;
  String weight;
  Team team;
  List<CareerElement> career;

  factory Career.fromJson(Map<String, dynamic> json) => Career(
    id: json["id"],
    name: json["name"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    age: json["age"],
    birth: Birth.fromJson(json["birth"]),
    nationality: json["nationality"],
    height: json["height"],
    weight: json["weight"],
    team: Team.fromJson(json["team"]),
    career: List<CareerElement>.from(json["career"].map((x) => CareerElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "firstname": firstname,
    "lastname": lastname,
    "age": age,
    "birth": birth.toJson(),
    "nationality": nationality,
    "height": height,
    "weight": weight,
    "team": team.toJson(),
    "career": List<dynamic>.from(career.map((x) => x.toJson())),
  };
}

class Birth {
  Birth({
    this.date,
    this.place,
    this.country,
  });

  DateTime date;
  String place;
  String country;

  factory Birth.fromJson(Map<String, dynamic> json) => Birth(
    date: DateTime.parse(json["date"]),
    place: json["place"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "place": place,
    "country": country,
  };
}

class CareerElement {
  CareerElement({
    this.team,
    this.start,
    this.end,
  });

  Team team;
  DateTime start;
  DateTime end;

  factory CareerElement.fromJson(Map<String, dynamic> json) => CareerElement(
    team: Team.fromJson(json["team"]),
    start: DateTime.parse(json["start"]),
    end: json["end"] == null ? null : DateTime.parse(json["end"]),
  );

  Map<String, dynamic> toJson() => {
    "team": team.toJson(),
    "start": "${start.year.toString().padLeft(4, '0')}-${start.month.toString().padLeft(2, '0')}-${start.day.toString().padLeft(2, '0')}",
    "end": end == null ? null : "${end.year.toString().padLeft(4, '0')}-${end.month.toString().padLeft(2, '0')}-${end.day.toString().padLeft(2, '0')}",
  };
}

class Team {
  Team({
    this.id,
    this.name,
    this.logo,
  });

  int id;
  String name;
  String logo;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
  };
}
