import 'package:flutter/material.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/models/player_json.dart';
import 'package:Fantasy/widgets/Player_Widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ClubPlayers extends StatefulWidget  {

  int clubId;

  ClubPlayers({this.clubId});

  @override
  _ClubPlayersState createState() => _ClubPlayersState();
}


class _ClubPlayersState extends State<ClubPlayers> {

  List<Player> results = [];

  Future<void>  getResults(int id) async {
    http.Response response = await http.get(
        'https://v3.football.api-sports.io/players?team=$id&season=2020&league=61',
        headers: {'x-rapidapi-key': ApiKey.key,
          'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    var data = jsonDecode(body);
    List<dynamic> clubList = data['response'];

    setState(() {
      results = clubList
          .map((dynamic item) => Player.fromJson(item))
          .toList();
    });

  }

  @override
  void initState() {
    super.initState();
    getResults(widget.clubId);
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
        : Scaffold(
      appBar: AppBar(
        title: Text("Players"),
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
            return PlayerWidget(id:results[index].id, name:results[index].name,lastname:results[index].lastname, image:results[index].image, club:results[index].club, position:results[index].position,
                nationality:results[index].nationality, age:results[index].age, matches:results[index].matches,
                goals:results[index].goals, assists:results[index].assists, saves:results[index].saves);
          },
          itemCount: results.length,
        ),
      ),
    );
  }
}

