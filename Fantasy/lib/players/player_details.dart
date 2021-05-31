import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/models/transfert_json.dart';

class PlayerDetails extends StatefulWidget {

  int id;
  String name;
  String lastname;
  String image;
  String club;
  String position;
  String nationality;
  String age;
  int matches;
  String goals;
  String assists;
  String saves;


  PlayerDetails({this.id,this.name, this.lastname,this.image, this.club, this.position,
      this.nationality, this.age, this.matches, this.goals, this.assists, this.saves});

  @override
  _PlayerDetailsState createState() => _PlayerDetailsState();
}

class _PlayerDetailsState extends State<PlayerDetails> {

  List<Response> teams = [];

  Future<void>  getTeams(int id) async {
    http.Response response = await http.get(
        'https://v3.football.api-sports.io/transfers?player=$id',
        headers: {'x-rapidapi-key': ApiKey.key,
          'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    var data = jsonDecode(body);
    List<dynamic> clubList = data['response'];

    setState(() {
      teams = clubList
          .map((dynamic item) => Response.fromJson(item))
          .toList();
    });

  }

  @override
  void initState() {
    super.initState();
    getTeams(widget.id);
  }

  @override
  Widget build(BuildContext context) {

    if(widget.matches == null ){
      widget.matches == 0;
    }
    if(widget.goals == null ){
      widget.goals == "0";
    }
    if(widget.assists == null ){
      widget.assists == "0";
    }
    if(widget.saves == null ){
      widget.saves == "0";
    }

    List<Stats> stats = [
      Stats("Matches", widget.matches.toString() ),
      Stats("Goals", widget.goals ),
      Stats("Assists", widget.assists ),
      Stats("Saves", widget.saves ),
    ];



    return Scaffold(
      appBar: AppBar(
        title: Text("Player Details"),
        backgroundColor: Colors.blue[300],
        elevation: 0.0,
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
                margin: EdgeInsets.fromLTRB(8.0,0,8.0,0),
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
                        Container(
                          height: 60,
                          width: 60,
                          child:
                          Image.network(this.widget.image,
                          ),
                        ),
                        const SizedBox(width:10.0),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget> [
                            Text(widget.name, style: TextStyle( fontWeight:FontWeight.bold,
                              fontSize: 18.0,
                            )),
                            Text(widget.lastname, style: TextStyle( fontWeight:FontWeight.bold,
                              fontSize: 18.0,
                            )),
                            const SizedBox(height: 5.0, ),
                            Text(widget.club, style: TextStyle( fontWeight:FontWeight.bold,
                              fontSize: 18.0,
                            )),
                            const SizedBox(height: 5.0, ),
                            Text("Role : "+widget.position, style: TextStyle( fontWeight:FontWeight.bold,
                              fontSize: 18.0, color: Colors.grey[600],
                            )),
                            const SizedBox(height: 5.0, ),
                            Text("Age : "+widget.age, style: TextStyle( fontWeight:FontWeight.bold,
                              fontSize: 18.0, color: Colors.grey[600],
                            )),
                            const SizedBox(height: 5.0, ),
                            Text("Nationality : "+widget.nationality, style: TextStyle( fontWeight:FontWeight.bold,
                              fontSize: 18.0, color: Colors.grey[600],
                            )),

                          ],
                        ),

                      ],
                    ),
                  ),
                ),
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
                margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                child:  Text(
                  "Teams",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              //////////////////////////////
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                child:   ListView.builder(
                  shrinkWrap: true,
                  itemCount: teams.length,
                  itemBuilder: (BuildContext context, int index) {
                    List<Transfers> transfers = teams[index].transfers;
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: transfers.length,
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
                                  backgroundImage: NetworkImage(transfers[index].teams.teamIn.logo),
                                ),
                                const SizedBox(width:10.0),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget> [
                                    Text(transfers[index].teams.teamIn.name, style: TextStyle( fontWeight:FontWeight.bold,
                                      fontSize: 18.0,
                                    )),
                                    const SizedBox(height: 5.0, ),
                                    Text("joined : "+transfers[index].date, style: TextStyle( fontWeight:FontWeight.bold,
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

