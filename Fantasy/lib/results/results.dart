import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/models/result_json.dart';
import 'package:Fantasy/widgets/match_result_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Results extends StatefulWidget  {

  int id;

  Results(this.id);

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
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
        title: Text("Match Results"),
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
               return MatchResult(results[index].home, results[index].homeGoals, results[index].homeImage, results[index].away, results[index].awayGoals, results[index].awayImage,results[index].date,results[index].time);
             },
               itemCount: results.length,
           ),
      ),



    );
  }
}

