class ListTeams {

  int id;
  String name;
  String image;
  


  ListTeams(this.id,this.name,this.image);

  factory ListTeams.fromJson(Map<String, dynamic> json) {
    return ListTeams(
        json['team']['id'],
        json['team']['name'],
        json['team']['logo'],
       
    );

  }


}