import 'package:flutter/material.dart';
import 'package:Fantasy/models/player_json.dart';
import 'package:Fantasy/widgets/Player_Widget.dart';


class Players extends StatelessWidget  {

  List<Player> results = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Players"),
        backgroundColor: Colors.blue[300],
        elevation: 0.0,
      ),
      body:
      ListView.builder(
        itemBuilder: (context, index){
          return PlayerWidget(id:results[index].id, name:results[index].name, image:results[index].image, club:results[index].club, position:results[index].position,
              nationality:results[index].nationality, age:results[index].age, matches:results[index].matches,
              goals:results[index].goals, assists:results[index].assists, saves:results[index].saves);
        },
        itemCount: results.length,
      ),
    );
  }
}

