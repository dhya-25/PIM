import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/models/award_json.dart';
import 'package:Fantasy/models/career_json.dart';
import 'manager_arguments.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class ManagerDetails extends StatefulWidget {

  int id;
  String name;
  String lastname;
  String image;
  String club;
  String nationality;
  int clubid;

  ManagerDetails({this.id,this.name,this.lastname,this.image,this.club,this.nationality,this.clubid});

  @override
  _ManagerDetailsState createState() => _ManagerDetailsState();
}

class _ManagerDetailsState extends State<ManagerDetails> {
  
  List<Career> teams = [];
  List<ManagerAwards> awards = [];


  Future<void> getCoach(int id) async {
    http.Response response = await http.get(
        'https://v3.football.api-sports.io/coachs?team=$id',
        headers: {'x-rapidapi-key': ApiKey.key,
          'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    Map data = jsonDecode(body);
    List<dynamic> table = data['response'];

    //Club(this.id,this.name,this.image,this.rank,this.nationality,this.stadium,this.manager,this.wins,this.draws,this.losses,this.goals,this.goalsIn);
    setState(() {
      print(id);
      teams = table
          .map((dynamic item) => Career.fromJson(item))
          .toList();
      // for ( var team in table){
      //   teams.add(Team(team['career'][0]['team']['name'], team['career'][0]['name'],
      //       team['career'][0]['start']));
      // }



      print("id"+data['response'][0]['career'].toString());
      print(data['response'][0]['lastname']);
      print(data['response'][0]['name']);
      print(data['response'][0]['team']['logo']);
      print(data['response'][0]['team']['name']);
      print(data['response'][0]['nationality']);
    });
  }


  Future<void> getAwards(int id) async {
    http.Response response = await http.get(
        'https://v3.football.api-sports.io/trophies?coach=$id',
        headers: {'x-rapidapi-key': ApiKey.key,
          'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    Map data = jsonDecode(body);
    List<dynamic> table = data['response'];

    //Club(this.id,this.name,this.image,this.rank,this.nationality,this.stadium,this.manager,this.wins,this.draws,this.losses,this.goals,this.goalsIn);
    setState(() {
      print(id);
      awards = table
          .map((dynamic item) => ManagerAwards.fromJson(item))
          .toList();
      print(awards);
    });
  }
  @override
  void initState() {
    super.initState();
    getCoach(widget.clubid);
    getAwards(widget.id);
    print(widget.id);

  }

  @override
  Widget build(BuildContext context) {

    return teams.length == 0 || awards.length == null
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
        title: Text("Manager Details"),
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
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.purple, Colors.blue])
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
                  child:    Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child:
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.image),
                          ),
                          const SizedBox(width:10.0),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget> [
                              Text(widget.name, style: TextStyle( fontWeight:FontWeight.bold,
                                fontSize: 18.0,
                              )),
                              const SizedBox(height: 5.0, ),
                              Text(widget.lastname, style: TextStyle( fontWeight:FontWeight.bold,
                                fontSize: 18.0,
                              )),
                              const SizedBox(height: 5.0, ),
                              Text(widget.club, style: TextStyle( fontWeight:FontWeight.bold,
                                fontSize: 18.0,
                              )),
                              const SizedBox(height: 5.0, ),
                              Text("Nationality:  "+widget.nationality, style: TextStyle( fontWeight:FontWeight.bold,
                                fontSize: 18.0, color: Colors.grey[600],
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 0, 10),
                  child:  Text(
                    "Coached teams",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                ),
           //////////////////////////////
            Container(
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child:   ListView.builder(
              shrinkWrap: true,
              itemCount: teams.length,
              itemBuilder: (BuildContext context, int index) {
                List<CareerElement> career = teams[index].career;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: career.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child:
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(career[index].team.logo),
                            ),
                            const SizedBox(width:10.0),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget> [
                                Text(career[index].team.name, style: TextStyle( fontWeight:FontWeight.bold,
                                  fontSize: 18.0,
                                )),
                                const SizedBox(height: 5.0, ),
                                Text("joined : "+career[index].start.toString(), style: TextStyle( fontWeight:FontWeight.bold,
                                  fontSize: 18.0, color: Colors.grey[600],
                                )),
                              ],
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                ) ;
              },
            ),
          ),
          //////////////////

                SizedBox(
                  height: 10,
                ),


                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child:  Text(
                    "Manager Awards",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(5, 20, 5, 0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics : NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child:
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: NetworkImage("https://www.impacttrophies.co.uk/content/images/thumbs/0045560_combo-winner-medal-ribbon.jpeg"),
                              ),
                              const SizedBox(width:10.0),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget> [
                                  Text(awards[index].league, style: TextStyle( fontWeight:FontWeight.bold,
                                    fontSize: 18.0,
                                  )),
                                  const SizedBox(height: 5.0, ),
                                  Text("country : "+awards[index].country, style: TextStyle( fontWeight:FontWeight.bold,
                                    fontSize: 18.0, color: Colors.grey[600],
                                  )),
                                  const SizedBox(height: 5.0, ),
                                  Text("year : "+awards[index].season, style: TextStyle( fontWeight:FontWeight.bold,
                                    fontSize: 18.0, color: Colors.grey[600],
                                  )),
                                ],
                              ),

                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: awards.length,
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

class Team {

  String name;
  String image;
  String date;

  Team(this.name,this.image,this.date);

}


class Titles {
  String name;
  String country;
  String club;
  String year;

  Titles(this.name,this.country,this.club,this.year);

}

class Awards {
  String name;
  String club;
  String year;

  Awards(this.name,this.club,this.year);

}

