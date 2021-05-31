// To parse this JSON data, do
//
//     final clubJson = clubJsonFromJson(jsonString);

import 'dart:convert';

ClubJson clubJsonFromJson(String str) => ClubJson.fromJson(json.decode(str));

String clubJsonToJson(ClubJson data) => json.encode(data.toJson());

class ClubJson {
    ClubJson({
        this.userid,
        this.email,
        this.password,
        this.name,
        this.price,
        this.points,
        this.fixture,
        this.players,
    });

    int userid;
    String email;
    String password;
    String name;
    double price;
    int points;
    String fixture;
    List<PlayerJson> players;

    factory ClubJson.fromJson(Map<String, dynamic> json) => ClubJson(
        userid: json["userid"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        price: json["price"],
        points: json["points"],
        fixture: json["fixture"],
        players: List<PlayerJson>.from(json["players"].map((x) => PlayerJson.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "userid": userid,
        "email": email,
        "password": password,
        "name": name,
        "price": price,
        "points": points,
        "fixture": fixture,
        "players": List<dynamic>.from(players.map((x) => x.toJson())),
    };
}

class PlayerJson {
    PlayerJson({
        this.id,
        this.firstname,
        this.lastname,
        this.position,
        this.price,
        this.rating,
        this.appearences,
        this.goals,
        this.assists,
        this.cleansheets,
        this.redcards,
        this.yellowcards,
        this.image,
        this.teamid
    });

    int id;
    String firstname;
    String lastname;
    String position;
    double price;
    String rating;
    int appearences;
    int goals;
    int assists;
    int cleansheets;
    int redcards;
    int yellowcards;
    String image;
    int teamid;

    factory PlayerJson.fromJson(Map<String, dynamic> json) => PlayerJson(
        id: json["id"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        position: json["position"],
        price: json["price"],
        rating: json["rating"],
        appearences: json["appearences"],
        goals: json["goals"],
        assists: json["assists"],
        cleansheets: json["cleansheets"],
        redcards: json["redcards"],
        yellowcards: json["yellowcards"],
        image: json["image"],
        teamid: json["teamid"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "position": position,
        "price": price,
        "rating": rating,
        "appearences": appearences,
        "goals": goals,
        "assists": assists,
        "cleansheets": cleansheets,
        "redcards": redcards,
        "yellowcards": yellowcards,
        "image": image,
        "teamid": teamid
    };
}