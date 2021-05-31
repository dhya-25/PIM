import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Fantasy/clubs/club_arguments.dart';
import 'package:Fantasy/routes/Routes.dart';
import 'package:flutter_svg/svg.dart';


class ClubWidget extends StatelessWidget  {

  int id;
  String name;
  String image;
  String rank;
  String nationality;
  String stadium;
  String manager;
  String wins;
  String draws;
  String losses;
  int goals;
  int goalsIn;


  ClubWidget(this.id,this.name,this.image,this.rank,this.nationality,this.stadium,this.manager,this.wins,this.draws,this.losses,this.goals,this.goalsIn);


  @override
  Widget build(BuildContext context) {

return Container(child:
InkWell(
  onTap: () {
    Navigator.pushNamed(
        context,
        Routes.ClubMenu,
        arguments: ClubArguments(id, name, image, rank, nationality, stadium , manager,wins,draws,losses,goals,goalsIn)
    );
  },
  child:  Card(
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
            height: 40,
            width: 40,
            child:
            Image.network(this.image,
            ),
          ),
          const SizedBox(width:10.0),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget> [
              Text(this.name, style: TextStyle( fontWeight:FontWeight.bold,
                fontSize: 18.0,
              )),
              const SizedBox(height: 5.0, ),
              Text("Rank : "+this.rank, style: TextStyle( fontWeight:FontWeight.bold,
                fontSize: 18.0, color: Colors.grey[600],
              )),
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

