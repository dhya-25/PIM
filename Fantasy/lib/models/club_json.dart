import 'dart:convert';

class ClubModel {

  int id;
  String name;
  String image;
  int rank;
  String nationality;
  String stadium;
  String manager;
  int wins;
  int draws;
  int losses;
  int goals;
  int goalsIn;


  ClubModel(this.id,this.name,this.image,this.rank,this.nationality,this.stadium,this.manager,this.wins,this.draws,this.losses,this.goals,this.goalsIn);

  factory ClubModel.fromJson(Map<String, dynamic> json) {
    return ClubModel(
        json['team']['id'],
        json['team']['name'],
        json['team']['logo'],
        json['rank'],
        "England",
       "Stadium",
        "Manager",
        json['all']['win'],
        json['all']['draw'],
        json['all']['lose'],
        json['all']['goals']['for'],
        json['all']['goals']['against']
    );

  }


}