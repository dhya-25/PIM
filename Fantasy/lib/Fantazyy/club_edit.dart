import 'dart:convert';

ClubEdit clubEditFromJson(String str) => ClubEdit.fromJson(json.decode(str));

String clubEditToJson(ClubEdit data) => json.encode(data.toJson());

class ClubEdit {
  ClubEdit({
    this.success,
    this.data,
  });

  int success;
  Data data;

  factory ClubEdit.fromJson(Map<String, dynamic> json) => ClubEdit(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.email,
    this.password,
    this.name,
    this.price,
    this.points,
    this.fixture,
    this.userid,
    this.players,
  });

  int id;
  String email;
  String password;
  String name;
  int price;
  int points;
  String fixture;
  int userid;
  List<Player> players;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    email: json["email"],
    password: json["password"],
    name: json["name"],
    price: json["price"],
    points: json["points"],
    fixture: json["fixture"],
    userid: json["userid"],
    players: List<Player>.from(json["players"].map((x) => Player.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "password": password,
    "name": name,
    "price": price,
    "points": points,
    "fixture": fixture,
    "userid": userid,
    "players": List<dynamic>.from(players.map((x) => x.toJson())),
  };
}

class Player {
  Player({
    this.id,
    this.firstname,
    this.lastname,
    this.position,
    this.price,
    this.appearences,
    this.rating,
    this.teamid,
    this.goals,
    this.assists,
    this.cleansheets,
    this.redcards,
    this.yellowcards,
    this.image,
    this.clubid,
    this.round,
    this.fixtureid,
    this.points,
  });

  int id;
  String firstname;
  String lastname;
  String position;
  int price;
  int appearences;
  String rating;
  int teamid;
  int goals;
  int assists;
  int cleansheets;
  int redcards;
  int yellowcards;
  String image;
  int clubid;
  Round round;
  int fixtureid;
  int points;

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    position: json["position"],
    price: json["price"],
    appearences: json["appearences"],
    rating: json["rating"],
    teamid: json["teamid"],
    goals: json["goals"],
    assists: json["assists"],
    cleansheets: json["cleansheets"],
    redcards: json["redcards"],
    yellowcards: json["yellowcards"],
    image: json["image"],
    clubid: json["clubid"],
    round: roundValues.map[json["round"]],
    fixtureid: json["fixtureid"],
    points: json["points"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstname": firstname,
    "lastname": lastname,
    "position": position,
    "price": price,
    "appearences": appearences,
    "rating": rating,
    "teamid": teamid,
    "goals": goals,
    "assists": assists,
    "cleansheets": cleansheets,
    "redcards": redcards,
    "yellowcards": yellowcards,
    "image": image,
    "clubid": clubid,
    "round": roundValues.reverse[round],
    "fixtureid": fixtureid,
    "points": points,
  };
}

enum Round { REGULAR_SEASON_36 }

final roundValues = EnumValues({
  "Regular Season - 36": Round.REGULAR_SEASON_36
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}