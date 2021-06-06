import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Fantasy/Fantazyy/club_edit.dart';
import 'package:Fantasy/Fantazyy/club_update.dart';
import 'package:Fantasy/Fantazyy/player_update_view.dart';
import 'package:Fantasy/Fantazyy/squad_list.dart';
import 'package:Fantasy/Fantazyy/styles.dart';
import 'package:Fantasy/Fantazyy/player%20copy.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'get_fixtures.dart';
import 'get_points.dart';
import 'insert_fixture.dart';
import 'package:Fantasy/Fantazyy/bottom_nav.dart';


class TeamDisplayView extends StatefulWidget {

  List<Playerr> selectedPlayers = [];

  TeamDisplayView({
    Key key,
    players,
    selectedPlayers,
  }) : selectedPlayers = (selectedPlayers == null) ? new List<Playerr>.generate(16, (int index) => null) : selectedPlayers;

  @override
  _TeamDisplayViewState createState() => _TeamDisplayViewState();
}

class _TeamDisplayViewState extends State<TeamDisplayView> {

  List<GetFixtures> results = [];
  String round;
  List<int> fixturesIds = [];
  List<PlayerUpdate> ple = [];
  int fixtureid;
  int clubids;


  PostRequest(String rnd) async {

// set up POST request arguments
    final url = Uri.parse('${ApiKey.url}/api/questions/addFixture');
    Map<String, String> headers = {"Content-type": "application/json"};
    List<Fixt> pls = [];

    for(var item in results){
      pls.add( Fixt(id: item.fixture.id,round: rnd)  );
    }

    InsertFixtures insertFx = InsertFixtures(fixt: pls);
    var json = jsonEncode(insertFx.toJson());

    // make POST request
    Response response = await post(url, headers: headers, body: json);
    String res = response.body;

    return response;
  }

  getClubId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      clubids = prefs.getInt("clubID");
    });



    print(clubids);

    http.Response response = await http.get(
        'https://v3.football.api-sports.io/fixtures?league=61&season=2020&last=1',
        headers: {'x-rapidapi-key': ApiKey.key,
          'x-rapidapi-host': 'v3.football.api-sports.io'});
    String body = response.body;
    var data = jsonDecode(body);
    List<dynamic> clubList = data['response'];

if(mounted){
    setState(() {
      results = clubList
          .map((dynamic item) => GetFixtures.fromJson(item))
          .toList();
      round = results[0].league.round.toString();
      fixtureid = results[0].fixture.id;
      fixture = round;
    });
  }
    makePostRequest(clubids);

  }

  Future<void> makePointsRequest(int clubid) async {
    // set up POST request arguments
    String url = '${ApiKey.url}/api/questions/getPoints';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"clubid": "' + clubid.toString() + '"}';
    Response response = await post(url, headers: headers, body: json);
    String res = response.body;
    Map parsed = jsonDecode(res);
    GetPoints club = GetPoints.fromJson(parsed);

    setState(() {
      points = club.data[0].points;
    });

    print("points" + points.toString());


  }


  Future<void> makePostRequest(int clubids) async {
    // set up POST request arguments
    String url = '${ApiKey.url}/api/questions/getclub';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"clubid": "' + clubids.toString() + '"}';
    Response response = await post(url, headers: headers, body: json);
    String res = response.body;
    Map parsed = jsonDecode(res);
    ClubEdit club = ClubEdit.fromJson(parsed);

    setState(() {
      clubName = club.data.name;
      //budget = club.data.price.toDouble();
      //points = club.data.points;
     // fixture = club.data.fixture;
    });
    print("clubname" + clubName);
    print("budget" + budget.toString());
    print("points" + points.toString());
    print("fixture" + fixture.toString());
    print(_isLoading);
    makePointsRequest(clubids);
  }

  Future<void>  getFixtures(int id,int plid,String fn,String ln,String ps,double price,String rating,int app, int goals, int assists, int cshet,int red, int yell,String img, int teamid) async {
    http.Response response = await http.get(
        'https://v3.football.api-sports.io/fixtures?team=$id&league=61&season=2020&next=1',
        headers: {'x-rapidapi-key': ApiKey.key,
          'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    var data = jsonDecode(body);
    List<dynamic> clubList = data['response'];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      results = clubList
          .map((dynamic item) => GetFixtures.fromJson(item))
          .toList();
      round = results[0].league.round.toString();
      fixtureid = results[0].fixture.id;
      ple.add(PlayerUpdate(
          id: plid,
          firstname: fn,
          lastname: ln,
          position: ps,
          price: price,
          rating: rating,
          appearences: app,
          goals: goals,
          assists: assists,
          cleansheets: cshet,
          redcards: red,
          yellowcards: yell,
          image: img,
          teamid: teamid,
          clubid: clubids,
          fixtureid: fixtureid
      ));
    });

            if(ple.length ==16 ){
              updateRequest(
                  userid,
                  "dhya@hotmail.com",
                  20,
                  "22",
                  "password",
                  "name",
                  25.0,
                 this.ple);
            }




    print("round     :"+round);
    prefs.setString("round",round);
//    this.PostRequest(round);
  }

  updateRequest(int userid, String email, int points, String fixtures,
      String password, String name, double price, List<PlayerUpdate> playerss) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("userEmail");
    password = prefs.getString("userPassword");
    int clubid = prefs.getInt("clubID");
    print(clubid);
    print("ple length"+playerss.length.toString());
    for(var item in playerss) {
      print("ple fixture" + item.fixtureid.toString());
    }
    setState(() {
      userid = prefs.getInt("userID");
    });
bool a = false;
for(var item in playerss){
  if(item == null){
    a = true;
  }
}
    if(a == true){
      Fluttertoast.showToast(
          msg: "Missing Players",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{


// set up POST request arguments
    final url = Uri.parse('${ApiKey.url}/api/questions/updateQuestion');
    Map<String, String> headers = {"Content-type": "application/json; charset=utf-8"};

    ClubUpdate club = ClubUpdate(
        userid: clubid,
        email: email,
        password: password,
        name: name,
        price: price,
        points: 0,
        fixture: fixture,
        players: playerss);

    var json = jsonEncode(club.toJson());
    print(json.toString());

    print(club.name);
    print(club.price);
    for (var item in club.players) {
      print("ple"+item.price.toString());
    }

    // make POST request
    Response response = await post(url, headers: headers, body: json);
    // check the status code for the result
    int statusCode = response.statusCode;
    // this API passes back the id of the new item added to the body
    String body = response.body;
    print("response body" + response.body);

    Fluttertoast.showToast(
        msg: "Team Updated Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {return SquadList();}));
    //Navigator.push(context, MaterialPageRoute(builder: (context)=>BodyFantasy(),),);
    }
    //return response;
  }

  int clubid;
  String clubName;
  bool _isLoading = true;
  double budget = 220.0;
  List<Playerr> pl = [];
  int points;
  String fixture;
  String _teamName = "";
  Widget _saveChanges = Text("Press to save changes");
  int userid;
  String email;
  String password;

  @override
  void initState() {
    super.initState();
    this.getClubId();

    for (Playerr player in widget.selectedPlayers) {
      if (player != null) {
          budget -= player.price;
      }

    }
    print("clubname" + clubName.toString());
    print("budget" + budget.toString());
    print("points" + points.toString());
    print("fixture" + fixture.toString());
    print(_isLoading);


  }

  emptyPlayer(int index) {

    Playerr player = widget.selectedPlayers[index];
    Widget playerView;

    if (player == null) {
      playerView = Image.asset(
        "Assets/shirt_blank.png",
        fit: BoxFit.fitHeight,
      );
    } else {
      playerView = Column(
        children: <Widget>[
          Expanded(
            child: Image.asset(
              player.image,
              fit: BoxFit.fitHeight,
            ),
          ),
          Container(
            color: Colors.white,
            child: Text(
              player.firstName.substring(0, 1) + ". " + player.lastName,
              textAlign: TextAlign.center,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
          Container(
            color: Colors.white,
            child: Text("£${player.price}m", textAlign: TextAlign.center),
          ),
        ],
      );
    }

    return Expanded(
      child: InkWell(
          onTap: () =>
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return PlayerUpdateView(
                      selectedPlayers: widget.selectedPlayers,
                      playerIndex: index,
                    );
                  })),
          child: Padding(
            padding: EdgeInsets.only(left: 3.0, right: 3.0),
            child: playerView,
          )),
    );

  }

  @override
  Widget build(BuildContext context) {

   return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                appBar: AppBar(
                  title: Text("Your team"),
                   elevation: 0.0,
                flexibleSpace: Container(decoration: 
        BoxDecoration(
          gradient: LinearGradient(colors: [Colors.black ,Colors.red],
          begin: Alignment.bottomRight,
          end:Alignment.topLeft)
        ),
        ),
                            leading: IconButton(
          onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>TabBarWidget(),),);
         },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
                ),
                body: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                            child: Stack(children: <Widget>[
                              
                          Positioned.fill(
                              child: Image.asset(
                            "Assets/pitch.jpg",
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topLeft,
                          ))
                        ])),
                      ],
                    ),
                    Column(
                      //players
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 6,
                            child: Padding(
                              padding: EdgeInsets.only(left: 40.0, right: 40.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: List.generate(
                                    2, (index) => emptyPlayer(index)),
                              ),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(
                                  5, (index) => emptyPlayer(index + 2)),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(
                                  5, (index) => emptyPlayer(index + 7)),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(
                                  4, (index) => emptyPlayer(index + 12)),
                            )),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          color: Styles.colorAccentDark,
                          padding: EdgeInsets.only(left: 8.0, right: 8.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        "Team Name",
                                        style: Styles.budgetLabel,
                                      ),
                                    ),
                                    Text(
                                      "${clubName}",
                                      style: Styles.budgetLabel,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        "Fixture",
                                        style: Styles.budgetLabel,
                                      ),
                                    ),
                                    Text(
                                      "${fixture}",
                                      style: Styles.budgetLabel,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        "Remaining Budget",
                                        style: Styles.budgetLabel,
                                      ),
                                    ),
                                    Text(
                                      "£${budget}m",
                                      style: Styles.budgetLabel,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        "Points",
                                        style: Styles.budgetLabel,
                                      ),
                                    ),
                                    Text(
                                      "${points}",
                                      style: Styles.budgetLabel,
                                    )
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),
                        new MaterialButton(
                            height: 50.0,
                            minWidth: double.infinity,
                            color: Styles.colorButton,
                            splashColor: Colors.teal,
                            textColor: Colors.white,
                            child: _saveChanges,
                            onPressed: () {

                              if (widget.selectedPlayers.length == 16) {
                                for(var item in widget.selectedPlayers){
                                  getFixtures(item.teamid,item.playerID,item.firstName,item.lastName,item.position,item.price,item.rating,item.appearances,item.goals,item.assists,item.cleanSheets,item.redCards,item.yellowCards,item.image,item.teamid);
                                }

                              }
                            }),
                      ],
                    ),
                  ],
                )));
  }
}
