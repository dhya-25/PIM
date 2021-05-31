import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Fantasy/Fantazyy/club_update.dart';
import 'package:Fantasy/Fantazyy/player_squad_json.dart';
import 'package:Fantasy/Fantazyy/squad_list.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/Screens/Login/login_screen.dart';
import 'package:Fantasy/Screens/Signup/signup_screen.dart';
import 'package:Fantasy/Screens/Welcome/components/background.dart';
import 'package:Fantasy/components/rounded_button.dart';
import 'package:Fantasy/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'club_api.dart';
import 'get_fixtures_results.dart';


class BodyResultsTwo extends StatefulWidget {

  List<PlayerSquad> players;
  int clubid;
  BodyResultsTwo({
    Key key,
    this.players,
    this.clubid,
  }): super(key: key);

  @override
  _BodyResultsState createState() => _BodyResultsState();
}

class _BodyResultsState extends State<BodyResultsTwo> {


  ClubSquadJson club;
  List<ClubApi> selectedClubs = [];
  List<int> clubIdentifiers = [];
  List<GetFixturesResults> playersjson = [];
  List<PlayerUpdate> playersApi = [];
  List<PlayerUpdate> playersFilter = [];
  int clubidsd;
  List<dynamic> playerList;
  List<PlayerElement> playerElements= [];
  List<Statisticc> playerstats = [];





  Future<void>  getPlayerStats(int fixture, int teamid, int playerid) async {

    http.Response response = await http.get(
        'https://v3.football.api-sports.io/fixtures/players?fixture=$fixture&team=$teamid',
        headers: {'x-rapidapi-key': ApiKey.key,
          'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    var data = jsonDecode(body);
    List<dynamic> clubList = data['response'][0]['players'];

    setState(() {
      playerElements = clubList
          .map((dynamic item) => PlayerElement.fromJson(item))
          .toList();

      for(var item in playerElements){
        String pos = item.statistics[0].games.position.toString().substring(9);
        playersApi.add(PlayerUpdate(id: item.player.id ,firstname: item.player.name,lastname: item.player.name,position: pos,price: 0,
            rating: item.statistics[0].games.rating,appearences:1 ,goals:item.statistics[0].goals.total ,assists: item.statistics[0].goals.assists ,cleansheets: item.statistics[0].goals.saves,
            redcards: item.statistics[0].cards.red,yellowcards: item.statistics[0].cards.yellow,image: item.player.photo,teamid: teamid ,clubid: widget.clubid,fixtureid: fixture));
      }

      playersFilter.addAll(playersApi.where((player) =>
      player.id == playerid).toList());

      print("Filter length"+playersFilter.length.toString());
      for(var item in playersFilter){
        print("filterid:  "+item.id.toString());
        print("filter name : "+item.firstname.toString());
        print(" filter points : "+item.points.toString());
      }
      print("Filter length"+playersFilter.length.toString());
      if(playersFilter.isNotEmpty){
        PostRequest(playersFilter);
      }
    });

  }


  PostRequest(List<PlayerUpdate> playerss) async {

    print("playerapilength  "+playerss.length.toString());
    final url = Uri.parse('${ApiKey.url}/api/questions/updatesFixtures');
    Map<String, String> headers = {"Content-type": "application/json"};

    ClubUpdate club = ClubUpdate(id:1,email:"d",password:"d",name:"d",price:5,points:5,fixture:"d",userid:1,players: playerss);

    var json = jsonEncode(club.toJson());
    print(club.name);


    // make POST request
    Response response = await post(url, headers: headers, body: json);
    String res = response.body;

  }



  @override
  void initState() {
  for(var item in widget.players){
  getPlayerStats(item.fixtureid, item.teamid, item.id);
  }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen

    print("players length"+widget.players.length.toString());

    return widget.players.isEmpty ||playerElements.length == 0|| playersFilter.length == 0
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
        : Scaffold(body: SquadList()
    );
  }
}