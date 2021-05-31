import 'dart:convert';

SquadJson squadJsonFromJson(String str) => SquadJson.fromJson(json.decode(str));

String squadJsonToJson(SquadJson data) => json.encode(data.toJson());

class SquadJson {
  SquadJson({
    this.success,
    this.data,
  });

  int success;
  List<Datum> data;

  factory SquadJson.fromJson(Map<String, dynamic> json) => SquadJson(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.firstname,
    this.lastname,
    this.position,
    this.price,
    this.appearences,
    this.goals,
    this.assists,
    this.cleansheets,
    this.redcards,
    this.yellowcards,
    this.image,
    this.clubid,
  });

  int id;
  String firstname;
  String lastname;
  String position;
  int price;
  int appearences;
  int goals;
  int assists;
  int cleansheets;
  int redcards;
  int yellowcards;
  String image;
  int clubid;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    position: json["position"],
    price: json["price"],
    appearences: json["appearences"],
    goals: json["goals"],
    assists: json["assists"],
    cleansheets: json["cleansheets"],
    redcards: json["redcards"],
    yellowcards: json["yellowcards"],
    image: json["image"],
    clubid: json["clubid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "position": position,
    "price": price,
    "appearences": appearences,
    "goals": goals,
    "assists": assists,
    "cleansheets": cleansheets,
    "redcards": redcards,
    "yellowcards": yellowcards,
    "image": image,
    "clubid": clubid,
  };
}