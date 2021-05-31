import 'dart:convert';

UsersClassements usersClassementsFromJson(String str) => UsersClassements.fromJson(json.decode(str));

String usersClassementsToJson(UsersClassements data) => json.encode(data.toJson());

class UsersClassements {
  UsersClassements({
    this.success,
    this.message,
    this.data,
  });

  int success;
  String message;
  List<Datums> data;

  factory UsersClassements.fromJson(Map<String, dynamic> json) => UsersClassements(
    success: json["success"],
    message: json["message"],
    data: List<Datums>.from(json["data"].map((x) => Datums.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datums {
  Datums({
    this.points,
    this.id,
    this.email,
    this.name,
    this.username,
  });

  int points;
  int id;
  String email;
  String name;
  String username;

  factory Datums.fromJson(Map<String, dynamic> json) => Datums(
    points: json["points"],
    id: json["id"],
    email: json["email"],
    name: json["name"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "points": points,
    "id": id,
    "email": email,
    "name": name,
    "username": username,
  };
}