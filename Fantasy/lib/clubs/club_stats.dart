import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/clubs/Clubs.dart';
import 'package:Fantasy/models/result_json.dart';
import 'package:Fantasy/widgets/match_result_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'club_arguments.dart';


class ClubStats extends StatefulWidget {

  int id;
  String name;
  String image;
  String rank;
  String nationality;
  String stadium;
  String manager;
  String wins;
  String draws;
  String losses;
  int goals;
  int goalsIn;

  ClubStats(
      {this.id,
        this.name,
        this.image,
        this.rank,
        this.nationality,
        this.stadium,
        this.manager,
        this.wins,
        this.draws,
        this.losses,
        this.goals,
        this.goalsIn});

  @override
  _ClubStatsState createState() => _ClubStatsState();
}

class _ClubStatsState extends State<ClubStats> {

  List<MResults> results = [];

  Future<void>  getResults(int id) async {
    http.Response response = await http.get(
        'https://v3.football.api-sports.io/fixtures?team=$id&season=2020&last=10',
        headers: {'x-rapidapi-key': ApiKey.key,
          'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    var data = jsonDecode(body);
    List<dynamic> clubList = data['response'];

    setState(() {
      results = clubList
          .map((dynamic item) => MResults.fromJson(item))
          .toList();
    });

  }

  @override
  void initState() {
    super.initState();
    getResults(widget.id);
  }


  @override
  Widget build(BuildContext context) {

    List<Stats> stats = [
      Stats("Wins", widget.wins ),
      Stats("Goal Difference", (widget.goals-widget.goalsIn).toString() ),
      Stats("Losses", widget.losses ),
      Stats("Draws", widget.draws ),
    ];

    return results.length == 0
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
        title: Text("Club Stats"),
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
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.purple, Colors.black38])),
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 15, 0, 0),
                  child:  Text(
                    "Season Stats",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.all(12.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: stats.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0
                      ),
                      itemBuilder: (BuildContext context, int index){
                        return Card(
                          child: Center(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topCenter,
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child:  Text(stats[index].result,style: TextStyle(fontSize: 20.0)),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(stats[index].title,style: TextStyle(fontSize: 25.0)),),

                                ]
                            ),
                          ),
                        );
                      },
                    )
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(15.0, 2.0, 2.0, 2.0),
                  child:  Text(
                    "Latest Matches",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(1.0, 5.0, 1.0, 5.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics : NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return MatchResult(results[index].home, results[index].homeGoals, results[index].homeImage, results[index].away, results[index].awayGoals, results[index].awayImage,results[index].date,results[index].time);
                    },
                    itemCount: results.length,
                  ),
                ),

                SizedBox(
                  height: 70,
                ),
              ],
            ),

          )
      ),
    );
  }
}


class Stats{

  String title;
  String result;

  Stats(this.title,this.result);

}


