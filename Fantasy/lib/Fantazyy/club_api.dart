// To parse this JSON data, do
//
//     final clubApi = clubApiFromJson(jsonString);

import 'dart:convert';

List<ClubApi> clubApiFromJson(String str) => List<ClubApi>.from(json.decode(str).map((x) => ClubApi.fromJson(x)));

String clubApiToJson(List<ClubApi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClubApi {
  ClubApi({
    this.team,
    this.venue,
  });

  Team team;
  Venue venue;

  factory ClubApi.fromJson(Map<String, dynamic> json) => ClubApi(
    team: Team.fromJson(json["team"]),
    venue: Venue.fromJson(json["venue"]),
  );

  Map<String, dynamic> toJson() => {
    "team": team.toJson(),
    "venue": venue.toJson(),
  };
}

class Team {
  Team({
    this.id,
    this.name,
    this.country,
    this.founded,
    this.national,
    this.logo,
  });

  int id;
  String name;
  String country;
  int founded;
  bool national;
  String logo;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["id"],
    name: json["name"],
    country: json["country"],
    founded: json["founded"],
    national: json["national"],
    logo: json["logo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "country": country,
    "founded": founded,
    "national": national,
    "logo": logo,
  };
}

class Venue {
  Venue({
    this.id,
    this.name,
    this.address,
    this.city,
    this.capacity,
    this.surface,
    this.image,
  });

  int id;
  String name;
  String address;
  String city;
  int capacity;
  String surface;
  String image;

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    city: json["city"],
    capacity: json["capacity"],
    surface: json["surface"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "city": city,
    "capacity": capacity,
    "surface": surface,
    "image": image,
  };
}