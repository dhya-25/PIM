import 'dart:convert';

ClubUpdate clubUpdateFromJson(String str) => ClubUpdate.fromJson(json.decode(str));

String clubUpdateToJson(ClubUpdate data) => json.encode(data.toJson());

class ClubUpdate {
  ClubUpdate({
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
  double price;
  int points;
  String fixture;
  int userid;
  List<PlayerUpdate> players;

  factory ClubUpdate.fromJson(Map<String, dynamic> json) => ClubUpdate(
    id: json["id"],
    email: json["email"],
    password: json["password"],
    name: json["name"],
    price: json["price"],
    points: json["points"],
    fixture: json["fixture"],
    userid: json["userid"],
    players: List<PlayerUpdate>.from(json["players"].map((x) => PlayerUpdate.fromJson(x))),
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

class PlayerUpdate {
  PlayerUpdate({
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
    this.teamid,
    this.clubid,
    this.fixtureid,
  }){


    if(rating == null){
      rating = "5.0";
     points-=2;
    }else if((double.parse(rating) >= 6.0) && (double.parse(rating) < 7.0)){

    }else if((double.parse(rating) >= 7.0) && (double.parse(rating) < 8.0)){
       points+=1;
    }else if((double.parse(rating) >= 8.0)&& (double.parse(rating) < 9.0)){
        points+=2;
    }else if (double.parse(rating) >= 9.0){
    points+=5;
    }
    if(appearences == null){
      appearences = 0;
    }

    if(position == null){
      position ="Sub";
    }


    if(redcards == null){
      redcards = 0;
    }

    if(yellowcards == null){
      yellowcards = 0;
    }

    if(price == null){
      price = 0;
    }

    if(goals == null){
      goals = 0;
    }else if(goals>=5 && goals < 10){
      price+=5;
    }else if(goals>=10 && goals <20){
      price+=10;
    }else if(goals>=20){
      price+=20;
    }
    if(assists == null){
      assists = 0;
    }else if(assists >= 5 && assists <10){
      price+=5;
    }else if(assists >= 10 && assists <20){
      price+=10;
    }else if(assists >= 10){
      price+=20;
    }

    if(cleansheets == null){
      cleansheets = 0;
    }else if(cleansheets >= 25 && cleansheets <30){
      price+=10;
    }else if(cleansheets >= 30){
      price+=15;
    }


    if(appearences == 0){
      points-=1;
    }else {
      points+=1;
      if (yellowcards == 1) {
        points -= 1;
      } else if (yellowcards == 2) {
        points -= 2;
      }
      if (redcards == 1) {
        points -= 2;
      }

      if (goals > 0) {
        points += (goals * 2);
      }

      if (assists > 0) {
        points += (assists * 2);
      }
      if(cleansheets >0){
        points+=(cleansheets*2);
      }
    }

  }

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
  int clubid;
  int fixtureid;
  int points = 0;

  factory PlayerUpdate.fromJson(Map<String, dynamic> json) => PlayerUpdate(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    position: json["position"],
    price: json["price"].toDouble(),
    rating: json["rating"],
    appearences: json["appearences"],
    goals: json["goals"],
    assists: json["assists"],
    cleansheets: json["cleansheets"],
    redcards: json["redcards"],
    yellowcards: json["yellowcards"],
    image: json["image"],
    teamid: json["teamid"],
    clubid: json["clubid"],
    fixtureid: json["fixtureid"],
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
    "teamid": teamid,
    "clubid": clubid,
    "fixtureid": fixtureid,
    "points": points
  };


}