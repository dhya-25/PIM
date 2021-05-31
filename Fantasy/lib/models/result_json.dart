class MResults {
  int id;
  String home;
  String homeImage;
  String away;
  String awayImage;
  String homeGoals;
  String awayGoals;
  String date;
  String time;

  MResults(this.id, this.home, this.homeGoals, this.homeImage, this.away,
      this.awayGoals, this.awayImage, this.date, this.time);

  factory MResults.fromJson(Map<String, dynamic> json) {
    return MResults(
        json['fixture']['id'],
        json['teams']['home']['name'],
        json['goals']['home'].toString(),
        json['teams']['home']['logo'],
        json['teams']['away']['name'],
        json['goals']['away'].toString(),
        json['teams']['away']['logo'],
        json['fixture']['date'],
        json['fixture']['date']
    );
  }
}