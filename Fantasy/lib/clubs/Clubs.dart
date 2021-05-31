import 'package:flutter/material.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/models/club_json.dart';
import 'package:Fantasy/widgets/Club_Widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Clubs extends StatefulWidget  {

  @override
  _ClubsState createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {

  List<ClubModel> results = [];

  Future<void>  getClubs() async {
    http.Response response = await http.get(
        'https://v3.football.api-sports.io/standings?season=2020&league=61',
        headers: {'x-rapidapi-key': ApiKey.key,
        'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    var data = jsonDecode(body);
    List<dynamic> clubList = data['response'][0]['league']['standings'][0];

    setState(() {
      results = clubList
          .map((dynamic item) => ClubModel.fromJson(item))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getClubs();
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
        title: Text("Clubs"),
        backgroundColor: Colors.blue[300],
        elevation: 0.0,
        flexibleSpace: Container(decoration: 
        BoxDecoration(
          gradient: LinearGradient(colors: [Colors.black ,Colors.red],
          begin: Alignment.bottomRight,
          end:Alignment.topLeft)
        ),),
      ),
      body:  Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Assets/bg.jpg"),
              fit: BoxFit.cover
            )
          ),
              child: ListView.builder(
          itemBuilder: (context, index){
            return ClubWidget(results[index].id,results[index].name, results[index].image, results[index].rank.toString(),results[index].nationality,
                results[index].stadium,results[index].manager,results[index].wins.toString(),results[index].draws.toString(),results[index].losses.toString(),
                results[index].goals,results[index].goalsIn);
          },
          itemCount: results.length,
        ),
      ),

    );
  }
}






