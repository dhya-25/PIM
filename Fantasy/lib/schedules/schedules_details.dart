import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/models/HomeAgainstAway.dart';
import 'package:Fantasy/models/result_json.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Fantasy/widgets/match_result_widget.dart';



class SchedulesDetails extends StatefulWidget {

  int id;
  String home;
  int homeId;
  String homeImage;
  String away;
  int awayId;
  String awayImage;
  String datetime;
  String stadium;
  String refree;

  SchedulesDetails(this.id,this.home,this.homeId,this.homeImage,this.away,this.awayId,this.awayImage,this.datetime,this.stadium,this.refree);

  @override
  _ClubStatsState createState() => _ClubStatsState();
}

class _ClubStatsState extends State<SchedulesDetails> {

  List<HomeVsAway> results = [];

  Future<void>  getResults(int id,int awayid) async {
    http.Response response = await http.get(
        'https://v3.football.api-sports.io/fixtures/headtohead?h2h=$id-$awayid&last=20',
        headers: {'x-rapidapi-key': ApiKey.key,
          'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    var data = jsonDecode(body);
    List<dynamic> clubList = data['response'];

    setState(() {
      results = clubList
          .map((dynamic item) => HomeVsAway.fromJson(item))
          .toList();
    });

  }

  @override
  void initState() {
    super.initState();
    getResults(widget.homeId,widget.awayId);
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
        title: Text("Club Stats"),
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
                      return MatchResult(results[index].teams.home.name.toString(), results[index].goals.home.toString(), results[index].teams.home.logo, results[index].teams.away.name,
                          results[index].goals.away.toString(),
                          results[index].teams.away.logo,results[index].fixture.date.toString(),results[index].fixture.date.toString());
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





