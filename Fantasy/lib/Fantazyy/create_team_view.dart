import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Fantasy/Fantazyy/bodyFantazy.dart';
import 'package:Fantasy/Fantazyy/club_json.dart';
import 'package:Fantasy/Fantazyy/controller.dart';
import 'package:Fantasy/Fantazyy/query_response.dart';
import 'package:Fantasy/Fantazyy/styles.dart';
import 'package:Fantasy/Fantazyy/player%20copy.dart';
import 'package:Fantasy/Fantazyy/players_creation_details_view.dart';
import 'package:Fantasy/Fantazyy/team_display_view.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/Screens/Login/components/body.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login_screen_Fantasy.dart';


class CreateTeamView extends StatefulWidget {

  List<Playerr> selectedPlayers;

  CreateTeamView({
    Key key,
    players,
    selectedPlayers,
  })  : selectedPlayers = (selectedPlayers == null) ? new List<Playerr>.generate(16, (int index) => null) : selectedPlayers;

  @override
  _CreateTeamViewState createState() => _CreateTeamViewState();

}




class _CreateTeamViewState extends State<CreateTeamView> {


  PostRequest(int userid,  String email, int points,String fixtures,String password,String name, double price, List<Playerr> players) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    userid=prefs.getInt("userID");
    email=prefs.getString("userEmail");
    password=prefs.getString("userPassword");


// set up POST request arguments
    final url = Uri.parse('${ApiKey.url}/api/questions/addQuestion');
    Map<String, String> headers = {"Content-type": "application/json"};
    List<PlayerJson> pl = [];
    for(var item in players){
      pl.add(PlayerJson(id:item.playerID,firstname:item.firstName.toString(),lastname:item.lastName.toString(),position:item.position.toString(), price:item.price,rating:item.rating, appearences:item.appearances,goals:item.goals,assists:item.assists,cleansheets:item.cleanSheets,redcards:item.redCards,yellowcards:item.yellowCards,image:item.image,teamid: item.teamid));
    }
    ClubJson club = ClubJson(userid: userid, email: email, password: password, name: name,  price: price, players: pl );



    var json = jsonEncode(club.toJson());
    print(club.name);

    print(club.name);
    print(club.price);

    // make POST request
    Response response = await post(url, headers: headers, body: json);
    String res = response.body;
    var parsed = jsonDecode(res);
    QueryResponse resp = QueryResponse.fromJson(parsed);

     if(resp.success == 0){
       Fluttertoast.showToast(
           msg: "Error , you have already a team with you account!",
           toastLength: Toast.LENGTH_LONG,
           gravity: ToastGravity.CENTER,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.white,
           fontSize: 16.0
       );
     }
    // var res = jsonDecode(response.body);
    // if(res == "success"){
    //

    return response;
  }

  final double _checkboxHeight = 30.0;
  double _startingBudget = 107.0;
  double _budget = 220.0;
  bool   _isTeamNameLong = false, _buttonEnabled = true;
  String _teamName = "";
  Widget _saveChanges = Text("Press to save changes");
  int userid;
  String email;
  String password;
  @override
  void initState() {
    Map<int,int> teamCount = new Map<int, int>();
    int fresherCount = 0;
    for (Playerr player in widget.selectedPlayers) {
      if (player != null) {
        _budget -= player.price;

      }
    }

    super.initState();
  }

  emptyPlayer(int index) {
    Playerr player = widget.selectedPlayers[index];
    Widget playerView;

    if (player == null) {
      playerView = Image.asset("Assets/shirt_blank.png", fit: BoxFit.fitHeight,);
    } else {
      playerView = Column(
        children: <Widget>[
          Expanded(
            child: Image.asset(player.image, fit: BoxFit.fitHeight,),
          ),
          Container(
            color: Colors.white,
            child: Text(player.firstName.substring(0,1) + ". " + player.lastName, textAlign: TextAlign.center, softWrap: false, overflow: TextOverflow.fade,),
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
          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {return PlayersCreationDetailsView(selectedPlayers: widget.selectedPlayers, playerIndex: index,);})),
          child: Padding(padding: EdgeInsets.only(left: 3.0, right: 3.0), child:playerView,)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
            appBar: AppBar(title: Text("Create your team"),
             elevation: 0.0,
                flexibleSpace: Container(decoration: 
        BoxDecoration(
          gradient: LinearGradient(colors: [Colors.black ,Colors.red],
          begin: Alignment.bottomRight,
          end:Alignment.topLeft)
        ),
        ),),
            body: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                  child: Image.asset("Assets/pitch.jpg", fit: BoxFit.fitWidth, alignment: Alignment.topLeft,)
                              )
                            ]
                        )
                    ),
                  ],
                ),
                Column( //players
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Container()
                    ),
                    Expanded(
                        flex: 6,
                        child:  Padding(
                          padding: EdgeInsets.only(left: 40.0, right: 40.0), child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(2, (index) => emptyPlayer(index)),
                        ),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Container()
                    ),
                    Expanded(
                        flex: 6,
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(5, (index) =>  emptyPlayer(index+2)),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Container()
                    ),
                    Expanded(
                        flex: 6,
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(5, (index) =>  emptyPlayer(index+7)),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Container()
                    ),
                    Expanded(
                        flex: 6,
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(4, (index) =>  emptyPlayer(index+12)),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Container()
                    ),
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
                                  child: Text("Remaining Budget", style: Styles.budgetLabel,),
                                ),
                                Text("£${_budget}m", style: Styles.budgetLabel,)
                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(bottom: 4.0,top:5.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                    child: TextField(
                                      onChanged: (string) {
                                        if (string.length >= 4) {
                                          _teamName = string;
                                          setState(() {
                                            _isTeamNameLong = true;
                                          });
                                        } else {
                                          setState(() {
                                            _isTeamNameLong = false;
                                          });
                                        }
                                      },
                                      decoration: InputDecoration(
                                        fillColor: Styles.colorBackgroundLight,
                                        filled: true,
                                        hintText: "Team Name",
                                      ),
                                    )
                                ),
                                Container(
                                  height: _checkboxHeight,
                                  child: Checkbox(
                                    value: _isTeamNameLong,
                                    onChanged: (bool) => null,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                    ,
                    new MaterialButton(

                        height: 50.0,
                        minWidth: double.infinity,
                        color: Styles.colorButton,
                        splashColor: Colors.teal,
                        textColor: Colors.white,
                        child: _saveChanges,
                        onPressed: () {

                          if (_buttonEnabled) {



                            if (!_isTeamNameLong) {
                              Fluttertoast.showToast(
                                  msg: " Your team name must be at least 4 characters long",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );

                            }
                            if (_budget < 0) {

                              Fluttertoast.showToast(
                                  msg: "You can't exceed the budget ",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }

                            bool a = false;
                            for(var item in widget.selectedPlayers){
                              if(item == null){
                                a = true;
                              }
                            }
                            if(a == true){

                              Fluttertoast.showToast(
                                  msg: "Missing Players ",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }


                            if((a == false)&&(_budget>=0)&&(_isTeamNameLong)){
                              PostRequest(userid,email,0,"31",password,_teamName,_budget,widget.selectedPlayers);
                              Fluttertoast.showToast(
                                  msg: "Team Created Successfully",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreenFantasy(),),);
                            }

                          }
                        }
                    ),

                  ],
                ),
              ],
            )
        );

  }

}