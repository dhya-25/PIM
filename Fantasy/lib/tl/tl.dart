import 'package:flutter/material.dart';
import 'package:Fantasy/clubs/Clubs.dart';
import 'package:Fantasy/managers/Managers.dart';
import 'package:Fantasy/players/Players.dart';
import 'package:Fantasy/results/results.dart';
import 'package:Fantasy/schedules/schedules.dart';
import 'package:Fantasy/tables%20copy/league_board.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TL extends StatelessWidget {

  int id;

  TL(this.id);

List<String> images = [
    "Assets/tt.jpg",
    "Assets/qatarairways.jpg",
    "Assets/LOGO_Danao.jpg",
    "Assets/delice.jpg"
  ];

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          
                  decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Assets/bg.jpg"),
              fit: BoxFit.cover
            )
          ),
          child: ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  "Premier League",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Column(
                  children: [
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 40,
                      child: RaisedButton(
                          child: Align(
                            child: Text(
                              "Match Results",
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.right,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Results(this.id)),
                            );
                          },
                          color: Colors.grey.shade300,
                          textColor: Colors.black,
                          padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                          splashColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 40,
                      child: RaisedButton(
                          child: Align(
                            child: Text(
                              "LeagueBoard",
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.right,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LeagueBoard()),
                            );
                          },
                          color: Colors.grey.shade300,
                          textColor: Colors.black,
                          padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                          splashColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 40,
                      child: RaisedButton(
                          child: Align(
                            child: Text(
                              "Broadcast Schedules",
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.right,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Schedules(this.id)),
                            );
                          },
                          color: Colors.grey.shade300,
                          textColor: Colors.black,
                          padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                          splashColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 40,
                      child: RaisedButton(
                          child: Align(
                            child: Text(
                              "Clubs",
                              style: TextStyle(fontSize: 17),
                              textAlign: TextAlign.right,
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Clubs()),
                            );
                          },
                          color: Colors.grey.shade300,
                          textColor: Colors.black,
                          padding: EdgeInsets.fromLTRB(15, 8, 8, 8),
                          splashColor: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0))),
                    ),

                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
   Container(
                  padding: EdgeInsets.all(12.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(images[index]);
                    },
                  )),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ));
  }
}
