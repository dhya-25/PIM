// To parse this JSON data, do
//
//     final playerrs = playerrsFromJson(jsonString);

import 'dart:convert';

List<Playerrs> playerrsFromJson(String str) => List<Playerrs>.from(json.decode(str).map((x) => Playerrs.fromJson(x)));

String playerrsToJson(List<Playerrs> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Playerrs {
  Playerrs({
    this.player,
    this.statistics,
  });

  Player player;
  List<Statistic> statistics;

  factory Playerrs.fromJson(Map<String, dynamic> json) => Playerrs(
    player: Player.fromJson(json["player"]),
    statistics: List<Statistic>.from(json["statistics"].map((x) => Statistic.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "player": player.toJson(),
    "statistics": List<dynamic>.from(statistics.map((x) => x.toJson())),
  };
}

class Player {
  Player({
    this.id,
    this.name,
    this.firstname,
    this.lastname,
    this.age,
    this.birth,
    this.nationality,
    this.height,
    this.weight,
    this.injured,
    this.photo,
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
  bool injured;
  String photo;

  factory Player.fromJson(Map<String, dynamic> json) => Player(
    id: json["id"],
    name: json["name"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    age: json["age"],
    birth: Birth.fromJson(json["birth"]),
    nationality: json["nationality"],
    height: json["height"] == null ? null : json["height"],
    weight: json["weight"] == null ? null : json["weight"],
    injured: json["injured"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "firstname": firstname,
    "lastname": lastname,
    "age": age,
    "birth": birth.toJson(),
    "nationality": nationality,
    "height": height == null ? null : height,
    "weight": weight == null ? null : weight,
    "injured": injured,
    "photo": photo,
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
    place: json["place"] == null ? null : json["place"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "place": place == null ? null : place,
    "country": country,
  };
}

class Statistic {
  Statistic({
    this.team,
    this.league,
    this.games,
    this.substitutes,
    this.shots,
    this.goals,
    this.passes,
    this.tackles,
    this.duels,
    this.dribbles,
    this.fouls,
    this.cards,
    this.penalty,
  });

  Team team;
  League league;
  Games games;
  Substitutes substitutes;
  Shots shots;
  Goals goals;
  Passes passes;
  Tackles tackles;
  Duels duels;
  Dribbles dribbles;
  Fouls fouls;
  Cards cards;
  Penalty penalty;

  factory Statistic.fromJson(Map<String, dynamic> json) => Statistic(
    team: Team.fromJson(json["team"]),
    league: League.fromJson(json["league"]),
    games: Games.fromJson(json["games"]),
    substitutes: Substitutes.fromJson(json["substitutes"]),
    shots: Shots.fromJson(json["shots"]),
    goals: Goals.fromJson(json["goals"]),
    passes: Passes.fromJson(json["passes"]),
    tackles: Tackles.fromJson(json["tackles"]),
    duels: Duels.fromJson(json["duels"]),
    dribbles: Dribbles.fromJson(json["dribbles"]),
    fouls: Fouls.fromJson(json["fouls"]),
    cards: Cards.fromJson(json["cards"]),
    penalty: Penalty.fromJson(json["penalty"]),
  );

  Map<String, dynamic> toJson() => {
    "team": team.toJson(),
    "league": league.toJson(),
    "games": games.toJson(),
    "substitutes": substitutes.toJson(),
    "shots": shots.toJson(),
    "goals": goals.toJson(),
    "passes": passes.toJson(),
    "tackles": tackles.toJson(),
    "duels": duels.toJson(),
    "dribbles": dribbles.toJson(),
    "fouls": fouls.toJson(),
    "cards": cards.toJson(),
    "penalty": penalty.toJson(),
  };
}

class Cards {
  Cards({
    this.yellow,
    this.yellowred,
    this.red,
  });

  int yellow;
  int yellowred;
  int red;

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
    yellow: json["yellow"] == null ? null : json["yellow"],
    yellowred: json["yellowred"] == null ? null : json["yellowred"],
    red: json["red"] == null ? null : json["red"],
  );

  Map<String, dynamic> toJson() => {
    "yellow": yellow == null ? null : yellow,
    "yellowred": yellowred == null ? null : yellowred,
    "red": red == null ? null : red,
  };
}

class Dribbles {
  Dribbles({
    this.attempts,
    this.success,
    this.past,
  });

  int attempts;
  int success;
  dynamic past;

  factory Dribbles.fromJson(Map<String, dynamic> json) => Dribbles(
    attempts: json["attempts"] == null ? null : json["attempts"],
    success: json["success"] == null ? null : json["success"],
    past: json["past"],
  );

  Map<String, dynamic> toJson() => {
    "attempts": attempts == null ? null : attempts,
    "success": success == null ? null : success,
    "past": past,
  };
}

class Duels {
  Duels({
    this.total,
    this.won,
  });

  int total;
  int won;

  factory Duels.fromJson(Map<String, dynamic> json) => Duels(
    total: json["total"] == null ? null : json["total"],
    won: json["won"] == null ? null : json["won"],
  );

  Map<String, dynamic> toJson() => {
    "total": total == null ? null : total,
    "won": won == null ? null : won,
  };
}

class Fouls {
  Fouls({
    this.drawn,
    this.committed,
  });

  int drawn;
  int committed;

  factory Fouls.fromJson(Map<String, dynamic> json) => Fouls(
    drawn: json["drawn"] == null ? null : json["drawn"],
    committed: json["committed"] == null ? null : json["committed"],
  );

  Map<String, dynamic> toJson() => {
    "drawn": drawn == null ? null : drawn,
    "committed": committed == null ? null : committed,
  };
}

class Games {
  Games({
    this.appearences,
    this.lineups,
    this.minutes,
    this.number,
    this.position,
    this.rating,
    this.captain,
  });

  int appearences;
  int lineups;
  int minutes;
  dynamic number;
  Position position;
  String rating;
  bool captain;

  factory Games.fromJson(Map<String, dynamic> json) => Games(
    appearences: json["appearences"] == null ? null : json["appearences"],
    lineups: json["lineups"] == null ? null : json["lineups"],
    minutes: json["minutes"] == null ? null : json["minutes"],
    number: json["number"],
    position: positionValues.map[json["position"]],
    rating: json["rating"] == null ? null : json["rating"],
    captain: json["captain"],
  );

  Map<String, dynamic> toJson() => {
    "appearences": appearences == null ? null : appearences,
    "lineups": lineups == null ? null : lineups,
    "minutes": minutes == null ? null : minutes,
    "number": number,
    "position": positionValues.reverse[position],
    "rating": rating == null ? null : rating,
    "captain": captain,
  };
}

enum Position { MIDFIELDER, ATTACKER, DEFENDER, GOALKEEPER }

final positionValues = EnumValues({
  "Attacker": Position.ATTACKER,
  "Defender": Position.DEFENDER,
  "Goalkeeper": Position.GOALKEEPER,
  "Midfielder": Position.MIDFIELDER
});

class Goals {
  Goals({
    this.total,
    this.conceded,
    this.assists,
    this.saves,
  });

  int total;
  int conceded;
  dynamic assists;
  dynamic saves;

  factory Goals.fromJson(Map<String, dynamic> json) => Goals(
    total: json["total"] == null ? null : json["total"],
    conceded: json["conceded"] == null ? null : json["conceded"],
    assists: json["assists"],
    saves: json["saves"],
  );

  Map<String, dynamic> toJson() => {
    "total": total == null ? null : total,
    "conceded": conceded == null ? null : conceded,
    "assists": assists,
    "saves": saves,
  };
}

class League {
  League({
    this.id,
    this.name,
    this.country,
    this.logo,
    this.flag,
    this.season,
  });

  int id;
  Name name;
  Country country;
  String logo;
  String flag;
  int season;

  factory League.fromJson(Map<String, dynamic> json) => League(
    id: json["id"],
    name: nameValues.map[json["name"]],
    country: countryValues.map[json["country"]],
    logo: json["logo"],
    flag: json["flag"],
    season: json["season"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": nameValues.reverse[name],
    "country": countryValues.reverse[country],
    "logo": logo,
    "flag": flag,
    "season": season,
  };
}

enum Country { ENGLAND }

final countryValues = EnumValues({
  "England": Country.ENGLAND
});

enum Name { PREMIER_LEAGUE }

final nameValues = EnumValues({
  "Premier League": Name.PREMIER_LEAGUE
});

class Passes {
  Passes({
    this.total,
    this.key,
    this.accuracy,
  });

  int total;
  int key;
  int accuracy;

  factory Passes.fromJson(Map<String, dynamic> json) => Passes(
    total: json["total"] == null ? null : json["total"],
    key: json["key"] == null ? null : json["key"],
    accuracy: json["accuracy"] == null ? null : json["accuracy"],
  );

  Map<String, dynamic> toJson() => {
    "total": total == null ? null : total,
    "key": key == null ? null : key,
    "accuracy": accuracy == null ? null : accuracy,
  };
}

class Penalty {
  Penalty({
    this.won,
    this.commited,
    this.scored,
    this.missed,
    this.saved,
  });

  dynamic won;
  dynamic commited;
  int scored;
  int missed;
  dynamic saved;

  factory Penalty.fromJson(Map<String, dynamic> json) => Penalty(
    won: json["won"],
    commited: json["commited"],
    scored: json["scored"] == null ? null : json["scored"],
    missed: json["missed"] == null ? null : json["missed"],
    saved: json["saved"],
  );

  Map<String, dynamic> toJson() => {
    "won": won,
    "commited": commited,
    "scored": scored == null ? null : scored,
    "missed": missed == null ? null : missed,
    "saved": saved,
  };
}

class Shots {
  Shots({
    this.total,
    this.on,
  });

  int total;
  int on;

  factory Shots.fromJson(Map<String, dynamic> json) => Shots(
    total: json["total"] == null ? null : json["total"],
    on: json["on"] == null ? null : json["on"],
  );

  Map<String, dynamic> toJson() => {
    "total": total == null ? null : total,
    "on": on == null ? null : on,
  };
}

class Substitutes {
  Substitutes({
    this.substitutesIn,
    this.out,
    this.bench,
  });

  int substitutesIn;
  int out;
  int bench;

  factory Substitutes.fromJson(Map<String, dynamic> json) => Substitutes(
    substitutesIn: json["in"] == null ? null : json["in"],
    out: json["out"] == null ? null : json["out"],
    bench: json["bench"] == null ? null : json["bench"],
  );

  Map<String, dynamic> toJson() => {
    "in": substitutesIn == null ? null : substitutesIn,
    "out": out == null ? null : out,
    "bench": bench == null ? null : bench,
  };
}

class Tackles {
  Tackles({
    this.total,
    this.blocks,
    this.interceptions,
  });

  int total;
  int blocks;
  int interceptions;

  factory Tackles.fromJson(Map<String, dynamic> json) => Tackles(
    total: json["total"] == null ? null : json["total"],
    blocks: json["blocks"] == null ? null : json["blocks"],
    interceptions: json["interceptions"] == null ? null : json["interceptions"],
  );

  Map<String, dynamic> toJson() => {
    "total": total == null ? null : total,
    "blocks": blocks == null ? null : blocks,
    "interceptions": interceptions == null ? null : interceptions,
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