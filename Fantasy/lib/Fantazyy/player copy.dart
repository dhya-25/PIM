// Copyright 2018 Leszek Nowaczyk. All rights reserved.
// If you get hold of this code you probably found it on github 😉

class Playerr {

  int _playerID;
  String _firstName;
  String _lastName;
  String _position;
  String _team;
  int _teamid;
  double _price = 5;
  String rating;
  int _appearances = 0;
  int _goals = 0;
  int _assists = 0;
  int _cleanSheets = 0;
  int _redCards = 0;
  int _yellowCards = 0;
  String _image;

  Playerr(this._playerID, this._firstName, this._lastName, this._position,
      this._team,this._teamid,
      this.rating, this._appearances, this._goals, this._assists,
      this._cleanSheets, this._redCards,
      this._yellowCards,this._image) {


    if(rating == null){
      rating = "5.000000";
      _price = 3;
    }else if((double.parse(rating) >= 6.0) && (double.parse(rating) < 7.0)){
    _price = 6;
    }else if((double.parse(rating) >= 7.0) && (double.parse(rating) < 8.0)){
      _price = 15;
    }else if(double.parse(rating) >= 8.0){
      _price = 30;
    }
    if(appearances == null){
      appearances = 0;
    }

    if(redCards == null){
      redCards = 0;
    }

    if(yellowCards == null){
      yellowCards = 0;
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

    if(cleanSheets == null){
      cleanSheets = 0;
    }else if(cleanSheets >= 25 && cleanSheets <30){
      price+=10;
    }else if(cleanSheets >= 30){
      price+=15;
    }

  }

  factory Playerr.fromJson(Map<String, dynamic> json) {
    return Playerr(int.parse(json['player']['id']), json['player']['firstname'], json['player']['lastname'],
     json['statistics'][0]['games']['position'],
     json['statistics'][0]['team']['name'],
        json['statistics'][0]['team']['id'],
        json['statistics'][0]['games']['rating'],
        int.parse(json['statistics'][0]['games']['appearances']),
        int.parse(json['statistics'][0]['goals']['total']),
         int.parse(json['statistics'][0]['goals']['assists']), int.parse(json['statistics'][0]['goals']['saves']),
        int.parse(json['statistics'][0]['cards']['yellow']), int.parse(json['statistics'][0]['cards']['red']),
        json['player']['photo']);
  }

  Playerr.empty() {
    this.image = "assets/shirt_blank.png";
    this.firstName = "firstname";
    this.lastName = "lastname";
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

 

  int get yellowCards => _yellowCards;

  set yellowCards(int value) {
    _yellowCards = value;
  }

  int get redCards => _redCards;

  set redCards(int value) {
    _redCards = value;
  }

  int get cleanSheets => _cleanSheets;

  set cleanSheets(int value) {
    _cleanSheets = value;
  }

  int get assists => _assists;

  set assists(int value) {
    _assists = value;
  }

  int get goals => _goals;

  set goals(int value) {
    _goals = value;
  }

  
  int get appearances => _appearances;

  set appearances(int value) {
    _appearances = value;
  }
  

  
  double get price => _price;

  set price(double value) {
    _price = value;
  }


  String get team => _team;

  set team(String value) {
    _team = value;
  }

  int get teamid => _teamid;

  set teamid(int value) {
    _teamid = value;
  }

  String get position => _position;

  set position(String value) {
    _position = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  String get firstName => _firstName;

  set firstName(String value) {
    _firstName = value;
  }

  int get playerID => _playerID;

  set playerID(int value) {
    _playerID = value;
  }

  String get fullName => _firstName + " " + _lastName;
}