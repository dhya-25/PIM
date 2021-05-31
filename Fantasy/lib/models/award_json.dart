// To parse this JSON data, do
//
//     final managerAwards = managerAwardsFromJson(jsonString);

import 'dart:convert';

List<ManagerAwards> managerAwardsFromJson(String str) => List<ManagerAwards>.from(json.decode(str).map((x) => ManagerAwards.fromJson(x)));

String managerAwardsToJson(List<ManagerAwards> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ManagerAwards {
  ManagerAwards({
    this.league,
    this.country,
    this.season,
    this.place,
  });

  String league;
  String country;
  String season;
  String place;

  factory ManagerAwards.fromJson(Map<String, dynamic> json) => ManagerAwards(
    league: json["league"],
    country: json["country"],
    season: json["season"],
    place: json["place"],
  );

  Map<String, dynamic> toJson() => {
    "league": league,
    "country": country,
    "season": season,
    "place": place,
  };
}
