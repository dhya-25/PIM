import 'dart:convert';

List<GetFixturesResults> getFixturesResultsFromJson(String str) => List<GetFixturesResults>.from(json.decode(str).map((x) => GetFixturesResults.fromJson(x)));

String getFixturesResultsToJson(List<GetFixturesResults> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetFixturesResults {
  GetFixturesResults({
    this.team,
    this.players,
  });

  Team team;
  List<PlayerElement> players;

  factory GetFixturesResults.fromJson(Map<String, dynamic> json) => GetFixturesResults(
    team: Team.fromJson(json["team"]),
    players: List<PlayerElement>.from(json["players"].map((x) => PlayerElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "team": team.toJson(),
    "players": List<dynamic>.from(players.map((x) => x.toJson())),
  };
}

class PlayerElement {
  PlayerElement({
    this.player,
    this.statistics,
  });

  PlayerPlayer player;
  List<Statisticc> statistics;

  factory PlayerElement.fromJson(Map<String, dynamic> json) => PlayerElement(
    player: PlayerPlayer.fromJson(json["player"]),
    statistics: List<Statisticc>.from(json["statistics"].map((x) => Statisticc.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "player": player.toJson(),
    "statistics": List<dynamic>.from(statistics.map((x) => x.toJson())),
  };
}

class PlayerPlayer {
  PlayerPlayer({
    this.id,
    this.name,
    this.photo,
  });

  int id;
  String name;
  String photo;

  factory PlayerPlayer.fromJson(Map<String, dynamic> json) => PlayerPlayer(
    id: json["id"],
    name: json["name"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photo": photo,
  };
}

class Statisticc {
  Statisticc({
    this.games,
    this.offsides,
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

  Games games;
  dynamic offsides;
  Shots shots;
  Goals goals;
  Passes passes;
  Tackles tackles;
  Duels duels;
  Dribbles dribbles;
  Fouls fouls;
  Cards cards;
  Penalty penalty;

  factory Statisticc.fromJson(Map<String, dynamic> json) => Statisticc(
    games: Games.fromJson(json["games"]),
    offsides: json["offsides"],
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
    "games": games.toJson(),
    "offsides": offsides,
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
    this.red,
  });

  int yellow;
  int red;

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
    yellow: json["yellow"],
    red: json["red"],
  );

  Map<String, dynamic> toJson() => {
    "yellow": yellow,
    "red": red,
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
  int past;

  factory Dribbles.fromJson(Map<String, dynamic> json) => Dribbles(
    attempts: json["attempts"] == null ? null : json["attempts"],
    success: json["success"] == null ? null : json["success"],
    past: json["past"] == null ? null : json["past"],
  );

  Map<String, dynamic> toJson() => {
    "attempts": attempts == null ? null : attempts,
    "success": success == null ? null : success,
    "past": past == null ? null : past,
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
    this.minutes,
    this.number,
    this.position,
    this.rating,
    this.captain,
    this.substitute,
  });

  int minutes;
  int number;
  Position position;
  String rating;
  bool captain;
  bool substitute;

  factory Games.fromJson(Map<String, dynamic> json) => Games(
    minutes: json["minutes"] == null ? null : json["minutes"],
    number: json["number"],
    position: positionValues.map[json["position"]],
    rating: json["rating"] == null ? null : json["rating"],
    captain: json["captain"],
    substitute: json["substitute"],
  );

  Map<String, dynamic> toJson() => {
    "minutes": minutes == null ? null : minutes,
    "number": number,
    "position": positionValues.reverse[position],
    "rating": rating == null ? null : rating,
    "captain": captain,
    "substitute": substitute,
  };
}

enum Position { G, D, M, F }

final positionValues = EnumValues({
  "D": Position.D,
  "F": Position.F,
  "G": Position.G,
  "M": Position.M
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
  int assists;
  int saves;

  factory Goals.fromJson(Map<String, dynamic> json) => Goals(
    total: json["total"] == null ? null : json["total"],
    conceded: json["conceded"],
    assists: json["assists"] == null ? null : json["assists"],
    saves: json["saves"] == null ? null : json["saves"],
  );

  Map<String, dynamic> toJson() => {
    "total": total == null ? null : total,
    "conceded": conceded,
    "assists": assists == null ? null : assists,
    "saves": saves == null ? null : saves,
  };
}

class Passes {
  Passes({
    this.total,
    this.key,
    this.accuracy,
  });

  int total;
  int key;
  String accuracy;

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

  int won;
  dynamic commited;
  int scored;
  int missed;
  int saved;

  factory Penalty.fromJson(Map<String, dynamic> json) => Penalty(
    won: json["won"] == null ? null : json["won"],
    commited: json["commited"],
    scored: json["scored"],
    missed: json["missed"],
    saved: json["saved"] == null ? null : json["saved"],
  );

  Map<String, dynamic> toJson() => {
    "won": won == null ? null : won,
    "commited": commited,
    "scored": scored,
    "missed": missed,
    "saved": saved == null ? null : saved,
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
    this.update,
  });

  int id;
  String name;
  String logo;
  DateTime update;

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    update: DateTime.parse(json["update"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "update": update.toIso8601String(),
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