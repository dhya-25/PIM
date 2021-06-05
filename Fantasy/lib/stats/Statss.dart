import 'package:flutter/material.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/stats/player_goals.dart';
import 'package:Fantasy/stats/teams_json.dart';
import 'package:Fantasy/tables%20copy/league_board.dart';
import 'package:Fantasy/Tables/TableSceen.dart';
import 'package:Fantasy/stats/player_assists.dart';
import 'package:Fantasy/stats/player_red_cards.dart';
import 'package:Fantasy/stats/player_yellow_cards.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'assist_json.dart';
import 'goals_json.dart';



class Statss extends StatefulWidget {

  const Statss({Key key}) : super(key: key);

  @override
  _StatssState createState() => _StatssState();
}

class _StatssState extends State<Statss> {

  List<AssistsJson> topassists = [];
  List<GoalsJson> topgoals = [];
  List<TeamsJson> teams = [];
  List<String> data = [];
  List<Choices> menu = [];
  String assister;
  String assisterphoto;
  String scorerphoto;
  String assists;
  String goals;
  String scorer;
  String teamgoals;
  String teamname;
  String teamphoto;
  String teampoints;


  Future<void>  getScorers() async {
    http.Response response = await http.get(
        'https://v3.football.api-sports.io/players/topscorers?league=61&season=2020',
        headers: {'x-rapidapi-key': ApiKey.key,
          'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    var data = jsonDecode(body);
    List<dynamic> clubList = data['response'];

    setState(() {
      topgoals = clubList
          .map((dynamic item) => GoalsJson.fromJson(item))
          .toList();
      goals = topgoals[0].statistics[0].goals.total.toString();
      scorer = topgoals[0].player.name+" "+topgoals[0].player.firstname;
      scorerphoto = topgoals[0].player.photo;
    });

  }

  Future<void>  getStandings() async {
    http.Response response = await http.get(
        'https://v3.football.api-sports.io/standings?league=61&season=2020',
        headers: {'x-rapidapi-key': ApiKey.key,
          'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    var data = jsonDecode(body);
    List<dynamic> clubList = data['response'];

    setState(() {
      teams = clubList
          .map((dynamic item) => TeamsJson.fromJson(item))
          .toList();
      teamgoals = teams[0].league.standings[0][0].all.goals.goalsFor.toString()+" "+"Goals";
      teamname =  teams[0].league.standings[0][0].team.name.toString();
      teamphoto = teams[0].league.standings[0][0].team.logo.toString();
      teampoints = teams[0].league.standings[0][0].points.toString()+" "+"Pts";

    });

  }

  Future<void>  getAssisters() async {
    http.Response response = await http.get(
        'https://v3.football.api-sports.io/players/topassists?league=61&season=2020',
        headers: {'x-rapidapi-key': ApiKey.key,
          'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    var data = jsonDecode(body);
    List<dynamic> clubList = data['response'];

    setState(() {
      topassists = clubList
          .map((dynamic item) => AssistsJson.fromJson(item))
          .toList();
      assists = topassists[0].statistics[0].goals.assists.toString();
      assister = topassists[0].player.name+" "+topassists[0].player.firstname;
      assisterphoto = topassists[0].player.photo;

    });

  }

  @override
  void initState() {
    super.initState();
    getScorers();
    getAssisters();
    getStandings();
  }

  List<String> images = [
    "Assets/tt.jpg",
    "Assets/qatarairways.jpg",
    "Assets/LOGO_Danao.jpg",
    "Assets/delice.jpg"
  ];


  @override
  Widget build(BuildContext context) {

    if(topgoals.isNotEmpty && topassists.isNotEmpty){     this.menu = [
      Choices("Top Scorer: ", goals.toString(), topgoals[0].player.name,topgoals[0].player.photo.toString()),
      Choices("Top Assister: ", assists.toString(), topassists[0].player.name,topassists[0].player.photo.toString()),
      Choices("Top Team Goals ", teamgoals.toString(), "",teamphoto.toString()),
      Choices("1 st Team ", teampoints.toString(), "",teamphoto.toString()),
    ];}
    return  teams.isEmpty || topassists.isEmpty || topgoals.isEmpty
        ? Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Color(0xFFe70066),
          ),
        ),
      ),
    )
        : Scaffold(
        appBar: AppBar(
          title: Text("Stats"),
          backgroundColor: Colors.blue[300],
        elevation: 0.0,
                flexibleSpace: Container(decoration: 
        BoxDecoration(
          gradient: LinearGradient(colors: [Colors.black ,Colors.red],
          begin: Alignment.bottomRight,
          end:Alignment.topLeft)
        ),
        ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Assets/bg.jpg"),
              fit: BoxFit.cover
            )
          ),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  "Statistiques",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: menu.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1.0,
                      mainAxisSpacing: 1.0),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.black,
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        //padding:  EdgeInsets.all(16.0),
                        child:
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                              height: 70,
                              width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(menu[index].image),
                              fit: BoxFit.fill
                          ),
                        ),
                      ),
                            Container(
                              padding: EdgeInsets.all(7.0),
                              width: double.infinity,
                              child:
                                  Center(
                                    child: Text(menu[index].title+" "+menu[index].name,style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white),),
                                  )
                            ),
                            Container(
                              padding: EdgeInsets.all(7.0),
                              width: double.infinity,
                              child: Center(
                                child:  Text(menu[index].record, style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),),
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.fromLTRB(15, 30, 15, 0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1,
                    ),
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 40,
                      child: RaisedButton(
                          child: Align(
                            child: Text(
                              "Top Scorers",
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.right,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Scorers()),
                            );
                          },
                          color: Colors.grey.shade300,
                          textColor: Colors.black,
                          padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                          splashColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 40,
                      child: RaisedButton(
                          child: Align(
                            child: Text(
                              "Top Assists",
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.right,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Assists()),
                            );
                          },
                          color: Colors.grey.shade300,
                          textColor: Colors.black,
                          padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                          splashColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 40,
                      child: RaisedButton(
                          child: Align(
                            child: Text(
                              "Yellow Cards",
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.right,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => YellowCards()),
                            );
                          },
                          color: Colors.grey.shade300,
                          textColor: Colors.black,
                          padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                          splashColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),

                    SizedBox(
                      height: 1,
                    ),
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 40,
                      child: RaisedButton(
                          child: Align(
                            child: Text(
                              "Red Cards",
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.right,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RedCards()),
                            );
                          },
                          color: Colors.grey.shade300,
                          textColor: Colors.black,
                          padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                          splashColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 40,
                      child: RaisedButton(
                          child: Align(
                            child: Text(
                              "Team Stats",
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.right,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => TableScreen()),
                            );
                          },
                          color: Colors.grey.shade300,
                          textColor: Colors.black,
                          padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                          splashColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),

                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(12.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(images[index]);
                    },
                  ),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ));
  }
}


class Choices {
  String title;
  String record;
  String name;
  String image;

  Choices(this.title,this.record,this.name,this.image);

}