// To parse this JSON data, do
//
//     final userApi = userApiFromJson(jsonString);

import 'dart:convert';

UserApi userApiFromJson(String str) => UserApi.fromJson(json.decode(str));

String userApiToJson(UserApi data) => json.encode(data.toJson());

class UserApi {
    UserApi({
        this.id,
        this.name,
        this.email,
        this.equipe,
        this.password,
    });

    int id;
    String name;
    String email;
    String equipe;
    String password;

    factory UserApi.fromJson(Map<String, dynamic> json) => UserApi(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        equipe: json["equipe"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "equipe": equipe,
        "password": password,
    };
}