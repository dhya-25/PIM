import 'dart:convert';

ClubV2 clubV2FromJson(String str) => ClubV2.fromJson(json.decode(str));

String clubV2ToJson(ClubV2 data) => json.encode(data.toJson());

class ClubV2 {
    ClubV2({
        this.id,
        this.email,
        this.password,
        this.name,
        this.price,
        this.points,
        this.fixture,
        this.userid,
    });

    int id;
    String email;
    String password;
    String name;
    int price;
    int points;
    String fixture;
    int userid;

    factory ClubV2.fromJson(Map<String, dynamic> json) => ClubV2(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        price: json["price"],
        points: json["points"],
        fixture: json["fixture"],
        userid: json["userid"],
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
    };
}