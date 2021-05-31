import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Fantasy/Fantazyy/club_update.dart';
import 'package:Fantasy/Fantazyy/player_squad_json.dart';
import 'package:Fantasy/Fantazyy/see_results_two.dart';
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

class BodyResults extends StatefulWidget {



  @override
  _BodyResultsState createState() => _BodyResultsState();
}

class _BodyResultsState extends State<BodyResults> {

  List<PlayerSquad> players = [];
  int clubidsd;

  ClubSquadJson club;



getClubIds() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  setState(() {
    clubidsd = prefs.getInt("clubID");
    print("clubid"+clubidsd.toString());
  });

  getPlayer(clubidsd);
}


Future<void> getPlayer(int ide) async {
  // set up POST request arguments
  String url = '${ApiKey.url}/api/questions/getclub';
  Map<String, String> headers = {"Content-type": "application/json"};
  String json = '{"clubid": "' + ide.toString() + '"}';
  Response response = await post(url, headers: headers, body: json);
  String res = response.body;
  Map parsed = jsonDecode(res);


  setState(() {
    club = ClubSquadJson.fromJson(parsed);
    for (var item in club.data.players) {
      String rnd = item.round.substring(8);
      players.add(PlayerSquad(
          id:item.id,
          firstname:item.firstname,
          lastname:item.lastname,
          position:item.position,
          price:item.price,
          appearences:item.appearences,
          rating:item.rating,
          teamid:item.teamid,
          goals:item.goals,
          assists:item.assists,
          cleansheets:item.cleansheets,
          redcards:item.redcards,
          yellowcards:item.yellowcards,
          image:item.image,
          clubid:item.clubid,
          round:rnd,
          fixtureid:item.fixtureid,
          points:item.points
      ));
    }
  
  });
}


@override
  void initState() {
   this.getClubIds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen

    print("players length"+players.length.toString());

    return players.length == 0
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
        : Scaffold(body:
     Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "MY SQUAD",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            /*SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),*/
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "SEE MY SQUAD",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BodyResultsTwo(players: players,clubid: this.clubidsd,);
                    },
                  ),
                );
              },
            ),

          ],
        ),
      ),
    ),
    );
  }
}