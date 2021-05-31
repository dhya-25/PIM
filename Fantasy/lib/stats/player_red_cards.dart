import 'package:flutter/material.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/models/player_json.dart';
import 'package:Fantasy/stats/assist_json.dart';
import 'package:Fantasy/stats/red_json.dart';
import 'package:Fantasy/stats/red_widget.dart';
import 'package:Fantasy/stats/yellow_json.dart';
import 'package:Fantasy/stats/yellow_widger.dart';
import 'package:Fantasy/widgets/Player_Widget.dart';
import 'assists_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RedCards extends StatefulWidget  {

  @override
  _AssistsState createState() => _AssistsState();
}

class _AssistsState extends State<RedCards> {
  List<RedJson> results = [];

  Future<void>  getResults() async {
    http.Response response = await http.get(
        'https://v3.football.api-sports.io/players/topredcards?league=61&season=2020',
        headers: {'x-rapidapi-key': ApiKey.key,
          'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    var data = jsonDecode(body);
    List<dynamic> clubList = data['response'];

    setState(() {
      results = clubList
          .map((dynamic item) => RedJson.fromJson(item))
          .toList();
    });

  }

  @override
  void initState() {
    super.initState();
    getResults();
  }

  @override
  Widget build(BuildContext context) {
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
        :Scaffold(
      appBar: AppBar(
        title: Text("Top Red Cards"),
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
      body:
      Container(
         decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Assets/bg.jpg"),
              fit: BoxFit.cover
            )
          ),
              child: ListView.builder(
          itemBuilder: (context, index){
            return RedWidget(id:results[index].player.id, name:results[index].player.name,lastname: results[index].player.lastname, image:results[index].player.photo, club:results[index].statistics[0].team.name,
                position:results[index].statistics[0].games.position.toString(),
                nationality:results[index].player.nationality, age:results[index].player.age.toString(), matches:results[index].statistics[0].games.appearences,
                goals:results[index].statistics[0].goals.total.toString(), assists:results[index].statistics[0].goals.assists.toString(),
                saves:results[index].statistics[0].goals.saves.toString(),red:results[index].statistics[0].cards.red.toString());
          },
          itemCount: results.length,
        ),
      ),
    );
  }
}

