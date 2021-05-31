import 'dart:convert';

InsertFixtures insertFixturesFromJson(String str) => InsertFixtures.fromJson(json.decode(str));

String insertFixturesToJson(InsertFixtures data) => json.encode(data.toJson());

class InsertFixtures {
  InsertFixtures({
    this.fixt,
  });

  List<Fixt> fixt;

  factory InsertFixtures.fromJson(Map<String, dynamic> json) => InsertFixtures(
    fixt: List<Fixt>.from(json["fixt"].map((x) => Fixt.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "fixt": List<dynamic>.from(fixt.map((x) => x.toJson())),
  };
}

class Fixt {
  Fixt({
    this.id,
    this.round,
  });

  int id;
  String round;

  factory Fixt.fromJson(Map<String, dynamic> json) => Fixt(
    id: json["id"],
    round: json["round"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "round": round,
  };
}