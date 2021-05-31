import 'package:flutter/material.dart';
import 'package:Fantasy/players/player_arguments.dart';
import 'package:Fantasy/players/player_details.dart';
import 'package:Fantasy/routes/Routes.dart';


class RedWidget extends StatefulWidget  {

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
  String red;
  String saves;

  RedWidget({this.id,this.name, this.lastname,this.image, this.club, this.position,
    this.nationality, this.age, this.matches, this.goals, this.assists, this.saves,this.red});

  @override
  _PlayerWidgetState createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<RedWidget> {

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  PlayerDetails(id: widget.id,name: this.widget.name, lastname: widget.lastname, image: this.widget.image, club: this.widget.club,position: this.widget.position,
                  nationality: this.widget.nationality, age: this.widget.age, matches: this.widget.matches, goals: this.widget.goals, assists: this.widget.assists,
                  saves:this.widget.saves)
          ),

          //   PlayerDetails(this.id,this.name, this.image, this.club, this.position,
          //       this.nationality, this.age, this.matches, this.goals, this.assists, this.saves);
        );

      },
      child: Container(
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
                    Text(this.widget.name, style: TextStyle( fontWeight:FontWeight.bold,
                      fontSize: 18.0,
                    )),
                    Text(this.widget.lastname, style: TextStyle( fontWeight:FontWeight.bold,
                      fontSize: 18.0,
                    )),
                    const SizedBox(height: 5.0, ),
                    Text(this.widget.club, style: TextStyle( fontWeight:FontWeight.bold,
                      fontSize: 18.0,
                    )),
                    const SizedBox(height: 5.0, ),
                    Text("Age : "+this.widget.age, style: TextStyle( fontWeight:FontWeight.bold,
                      fontSize: 18.0, color: Colors.grey[600],
                    )),
                    const SizedBox(height: 5.0, ),
                    Text("Position : "+this.widget.position, style: TextStyle( fontWeight:FontWeight.bold,
                      fontSize: 18.0, color: Colors.grey[600],
                    )),
                    const SizedBox(height: 5.0, ),
                    Text("club : "+this.widget.club, style: TextStyle( fontWeight:FontWeight.bold,
                      fontSize: 18.0, color: Colors.grey[600],
                    )),
                    Text("Red Cards: "+this.widget.red, style: TextStyle( fontWeight:FontWeight.bold,
                      fontSize: 18.0,
                    )),
                    const SizedBox(height: 5.0, ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );

  }
}

