import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;


class LeagueBoard extends StatefulWidget {

  @override
  _LeagueBoardState createState() => _LeagueBoardState();
}

class _LeagueBoardState extends State<LeagueBoard> {

  List<Club> clubs = [];

  Future<void> getTable() async {
    http.Response response = await http.get(
        'http://api.football-data.org/v2/competitions/FL1/standings',
        headers: {'X-Auth-Token': '86014f6025ae430dba078acc94bb2647'});
    String body = response.body;
    Map data = jsonDecode(body);
    List table = data['standings'][0]['table'];

    setState(() {
      for (var team in table) {
        clubs.add(Club(team['team']['name'],team['team']['crestUrl'], team['position'].toString(),team['points'].toString(),team['playedGames'].toString(),team['won'].toString(),
            team['draw'].toString(),team['lost'].toString(),team['goalsFor'],team['goalsAgainst']));
        print("hello");
      }
    });
  }


  @override
  void initState() {
    super.initState();
    getTable();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.bold);
 return clubs.length == 0
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
     title: Text("LeagueBoard"),
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
   body: SingleChildScrollView(
     child: Column(
       children: [
         TopRow(),
         ListView.builder(
           shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
           primary: false,
           itemCount: clubs.length,
           itemBuilder: (context, index) {
             return TableRow(index: index, clubs:clubs);
           },
         ),
         SizedBox(width: 50,),
        Container(
         padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.center,
                  colors: [Colors.purple[100], Colors.red[100]])
          ),
          margin: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 30.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    width: 30,
                    height: 30,
                    color: Colors.blue,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    child: Text("Champions League",style: textStyle)
                    ,)
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(5.0),
                    alignment: Alignment.center,
                    width: 30,
                    height: 30,
                    color: Colors.red[400],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    child: Text("Europa League",style: textStyle)
                    ,)

                ],
              ),
              Row(children: [
                Container(
                  margin: EdgeInsets.all(5.0),
                  alignment: Alignment.center,
                  width: 30,
                  height: 30,
                  color: Colors.red[800],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                  child: Text("Division 2",style: textStyle)
                  ,)
              ],
              ),
            ],
          )
          ,
        )
       ],
     ),
   ),
    );
  }
}

class TopRow extends StatelessWidget {
  const TopRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 11, fontWeight: FontWeight.bold);
    TextStyle textStyle2 = TextStyle(fontSize: 13);

    return Container(
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 30,
            height: 30,
            child: Text('#'),
          ),
          SizedBox(width: 20),
          Container(alignment: Alignment.center, child: Text('Team')),
          Spacer(),
          Container(
            width: 28,
            child: Text('MP', style: textStyle),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: 28,
            child: Text('W', style: textStyle),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: 28,
            child: Text('D', style: textStyle),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: 28,
            child: Text('L', style: textStyle),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: 28,
            child: Text('GD', style: textStyle),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: 28,
            child: Text('Pts', style: textStyle),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: 5,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[800],
            ),
            padding: EdgeInsets.fromLTRB(10, 5, 2, 5),
          ),
        ],
      ),
    );

  }
}

class TableRow extends StatelessWidget {
  final int index;
  final List<Club> clubs;
  const TableRow({
    this.index,
    this.clubs,
    Key key,
  }) : super(key: key);
/////////////////////////////////////////////////////////////////////linkwell
  ////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 11, fontWeight: FontWeight.bold);
    TextStyle textStyle2 = TextStyle(fontSize: 13, fontWeight: FontWeight.bold);
    return Container(
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38, width: 0.2),
        color: index == 0  ? Colors.yellow[100] : Colors.purpleAccent[20],
      ),
      child: Row(
        children: [
          Container(//iinkwell
            alignment: Alignment.center,
            width: 30,
            height: 40,
            color: index < 2
                ? Colors.blue
                : index == 2

                ? Colors.red[400]
                : index > 17
                ? Colors.red[800]
                : Colors.grey[700],
            child: Text(
              (index + 1).toString(),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 20),
          Row(children: [
            Container(
              height: 24,
              width: 24,
              child:
            SvgPicture.network(clubs[index].image,

            ),
              ),

            SizedBox(width: 5.0),
           clubs[index].name.length > 11
                ? Text(clubs[index].name
                .toString()
                .substring(0, 11) +
                '...')
                : Text(clubs[index].name.toString(), style: textStyle2),
          ],),


          Spacer(),
          Container(
            width: 28,
            child: Text(clubs[index].matches, style: textStyle2),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: 28,
            child: Text(clubs[index].wins, style: textStyle2),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: 28,
            child: Text(clubs[index].draws, style: textStyle2),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: 28,
            child: Text(clubs[index].loss, style: textStyle2),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: 28,
            child: Text((clubs[index].goals - clubs[index].goalsIn).toString(), style: textStyle2),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: 28,
            child: Text(clubs[index].points, style: textStyle2),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            width: 5,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey[600],
            ),
            padding: EdgeInsets.fromLTRB(10, 5, 2, 5),
          ),
        ],
      ),
    );
  }
}



class Club {

  String name;
  String image;
  String rank;
  String points;
  String matches;
  String wins;
  String loss;
  String draws;
  int goals;
  int goalsIn;

  Club(this.name,this.image,this.rank,this.points, this.matches,this.wins,this.loss,this.draws,this.goals,this.goalsIn);

}


