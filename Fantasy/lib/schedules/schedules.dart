import 'package:flutter/material.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/models/schedule_json.dart';
import 'package:Fantasy/widgets/schedule_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Schedules extends StatefulWidget  {

  int id;
  Schedules(this.id);

  @override
  _SchedulesState createState() => _SchedulesState();
}

class _SchedulesState extends State<Schedules> {

  List<Schedule> results = [];

  Future<void>  getResults(int id) async {

    http.Response response = await http.get(
        'https://v3.football.api-sports.io/fixtures?league=61&season=2020&team=$id&next=20',
        headers: {'x-rapidapi-key': ApiKey.key,
          'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    var data = jsonDecode(body);
    List<dynamic> clubList = data['response'];

    setState(() {
      results = clubList
          .map((dynamic item) => Schedule.fromJson(item))
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
        title: Text("Broadcast Schedules"),
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
            return BroadcastSchedule(results[index].fixture.id,results[index].teams.home.name,results[index].teams.home.id, results[index].teams.home.logo,
                results[index].teams.away.name, results[index].teams.away.id, results[index].teams.away.logo, results[index].fixture.date.toString(),
                results[index].fixture.venue.name,results[index].fixture.referee);
          },
          itemCount: results.length,
        ),
      ),

    );

  }
}

