import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/models/manager_json.dart';
import 'package:Fantasy/widgets/Manager_widget.dart';
import 'club_arguments.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ClubDetails extends StatefulWidget {

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

  ClubDetails(
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
  _ClubDetailsState createState() => _ClubDetailsState();
}

class _ClubDetailsState extends State<ClubDetails> {
  
  String std;
  int fnd = 0;
  Manager manager;
  int    managerid;
  String managername;
  String managerlastname;
  String managerimage;
  String managerclub;
  String managernationality;

  Future<void> getClub(int id) async {
    http.Response response = await http.get(
        'https://v3.football.api-sports.io/teams?id=$id',
        headers: {'x-rapidapi-key': ApiKey.key,
          'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    Map data = jsonDecode(body);



    //Club(this.id,this.name,this.image,this.rank,this.nationality,this.stadium,this.manager,this.wins,this.draws,this.losses,this.goals,this.goalsIn);
    setState(() {
      //print(data[0]['venue']);
      this.std = data['response'][0]['venue']['name'];
      this.fnd = data['response'][0]['team']['founded'];
    });
  }


  Future<void> getCoach(int id) async {
    http.Response response = await http.get(
        'https://v3.football.api-sports.io/coachs?team=$id',
        headers: {'x-rapidapi-key': ApiKey.key,
          'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    Map data = jsonDecode(body);

    //Club(this.id,this.name,this.image,this.rank,this.nationality,this.stadium,this.manager,this.wins,this.draws,this.losses,this.goals,this.goalsIn);
    setState(() {
      //print(data[0]['venue']);
      print(id);
       this.managerid = data['response'][0]['id'];
       this.managername = data['response'][0]['firstname'];
       this.managerlastname = data['response'][0]['name'];
       this.managerimage = data['response'][0]['team']['logo'];
       this.managerclub = data['response'][0]['team']['name'];
       this.managernationality = data['response'][0]['nationality'];
      print("id"+data['response'][0]['id'].toString());
      print(data['response'][0]['lastname']);
      print(data['response'][0]['name']);
      print(data['response'][0]['team']['logo']);
      print(data['response'][0]['team']['name']);
      print(data['response'][0]['nationality']);
    });
  }
  @override
  void initState() {
    super.initState();
    getClub(widget.id);
    getCoach(widget.id);
    print(widget.id);
    print(std);
    print((fnd).toString());
  }

  @override
  Widget build(BuildContext context) {
    List<Titles> titles = [
      Titles("LA LIGA", "Spain", "Barcelona", "2008"),
    ];

    return (std == null || fnd == 0)
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
        title: Text("Club Info"),
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
                  width: double.infinity,
                  child: Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 60,
                            width: 60,
                            child: Image.network(
                              widget.image,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(widget.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  )),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text("rank : " +widget.rank,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  )),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text("Founded : " +fnd.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  )),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text("Nationality : " +widget.nationality,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Colors.grey[600],
                                  )),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Text("Stadium : " +std,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Colors.grey[600],
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 10,
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child:  Text(
                    "Coach",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                ),

                Container(
                  width: double.infinity,
                  child: ManagerWidget(id: this.managerid,name:this.managername,lastname:this.managerlastname, image:this.managerimage,
                      club: this.managerclub, nationality: this.managernationality, clubid: widget.id,)
                ),

                SizedBox(
                  height: 70,
                ),
              ],
            ),
          )),
    );
  }
}

class Stats {
  String title;
  String result;

  Stats(this.title, this.result);
}

class Team {
  String name;
  String image;
  String date;

  Team(this.name, this.image, this.date);
}

class Titles {
  String name;
  String country;
  String club;
  String year;

  Titles(this.name, this.country, this.club, this.year);
}

class Club {
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

  Club(
      this.id,
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
      this.goalsIn);
}
