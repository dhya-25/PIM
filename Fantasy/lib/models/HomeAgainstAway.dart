// To parse this JSON data, do
//
//     final homeVsAway = homeVsAwayFromJson(jsonString);

import 'dart:convert';

List<HomeVsAway> homeVsAwayFromJson(String str) => List<HomeVsAway>.from(json.decode(str).map((x) => HomeVsAway.fromJson(x)));

String homeVsAwayToJson(List<HomeVsAway> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeVsAway {
  HomeVsAway({
    this.fixture,
    this.league,
    this.teams,
    this.goals,
    this.score,
  });

  Fixture fixture;
  League league;
  Teams teams;
  Goals goals;
  Score score;

  factory HomeVsAway.fromJson(Map<String, dynamic> json) => HomeVsAway(
    fixture: Fixture.fromJson(json["fixture"]),
    league: League.fromJson(json["league"]),
    teams: Teams.fromJson(json["teams"]),
    goals: Goals.fromJson(json["goals"]),
    score: Score.fromJson(json["score"]),
  );

  Map<String, dynamic> toJson() => {
    "fixture": fixture.toJson(),
    "league": league.toJson(),
    "teams": teams.toJson(),
    "goals": goals.toJson(),
    "score": score.toJson(),
  };
}

class Fixture {
  Fixture({
    this.id,
    this.referee,
    this.timezone,
    this.date,
    this.timestamp,
    this.periods,
    this.venue,
    this.status,
  });

  int id;
  String referee;
  String timezone;
  DateTime date;
  int timestamp;
  League periods;
  League venue;
  League status;

  factory Fixture.fromJson(Map<String, dynamic> json) => Fixture(
    id: json["id"],
    referee: json["referee"],
    timezone: json["timezone"],
    date: DateTime.parse(json["date"]),
    timestamp: json["timestamp"],
    periods: League.fromJson(json["periods"]),
    venue: League.fromJson(json["venue"]),
    status: League.fromJson(json["status"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "referee": referee,
    "timezone": timezone,
    "date": date.toIso8601String(),
    "timestamp": timestamp,
    "periods": periods.toJson(),
    "venue": venue.toJson(),
    "status": status.toJson(),
  };
}

class League {
  League();

  factory League.fromJson(Map<String, dynamic> json) => League(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Goals {
  Goals({
    this.home,
    this.away,
  });

  int home;
  int away;

  factory Goals.fromJson(Map<String, dynamic> json) => Goals(
    home: json["home"],
    away: json["away"],
  );

  Map<String, dynamic> toJson() => {
    "home": home,
    "away": away,
  };
}

class Score {
  Score({
    this.halftime,
    this.fulltime,
    this.extratime,
    this.penalty,
  });

  League halftime;
  League fulltime;
  League extratime;
  League penalty;

  factory Score.fromJson(Map<String, dynamic> json) => Score(
    halftime: League.fromJson(json["halftime"]),
    fulltime: League.fromJson(json["fulltime"]),
    extratime: League.fromJson(json["extratime"]),
    penalty: League.fromJson(json["penalty"]),
  );

  Map<String, dynamic> toJson() => {
    "halftime": halftime.toJson(),
    "fulltime": fulltime.toJson(),
    "extratime": extratime.toJson(),
    "penalty": penalty.toJson(),
  };
}

class Teams {
  Teams({
    this.home,
    this.away,
  });

  Away home;
  Away away;

  factory Teams.fromJson(Map<String, dynamic> json) => Teams(
    home: Away.fromJson(json["home"]),
    away: Away.fromJson(json["away"]),
  );

  Map<String, dynamic> toJson() => {
    "home": home.toJson(),
    "away": away.toJson(),
  };
}

class Away {
  Away({
    this.id,
    this.name,
    this.logo,
    this.winner,
  });

  int id;
  String name;
  String logo;
  bool winner;

  factory Away.fromJson(Map<String, dynamic> json) => Away(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    winner: json["winner"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "winner": winner,
  };
}
