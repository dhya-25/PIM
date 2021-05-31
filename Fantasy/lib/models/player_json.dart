class Player {

  int id;
  String name;
  String lastname;
  String image;
  String club;
  String position;
  String nationality;
  String age;
  int matches;
  String goals;
  String assists;
  String saves;

  Player(this.id,this.name, this.lastname, this.image, this.club, this.position,
      this.nationality, this.age, this.matches, this.goals, this.assists, this.saves);

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
        json['player']['id'],
        json['player']['firstname'],
        json['player']['lastname'],
        json['player']['photo'],
        json['statistics'][0]['team']['name'],
        json['statistics'][0]['games']['position'],
        json['player']['nationality'],
        json['player']['age'].toString(),
        json['statistics'][0]['games']['appearences'],
        json['statistics'][0]['goals']['total'].toString(),
        json['statistics'][0]['goals']['assists'].toString(),
        json['statistics'][0]['goals']['saves'].toString(),

    );
  }

}