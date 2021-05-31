import 'package:flutter/material.dart';
import 'package:Fantasy/schedules/schedules_details.dart';

class BroadcastSchedule extends StatelessWidget  {

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

  BroadcastSchedule(this.id,this.home,this.homeId,this.homeImage,this.away,this.awayId,this.awayImage,this.datetime,this.stadium,this.refree);


  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  SchedulesDetails(this.id,this.home,this.homeId,this.homeImage,this.away,this.awayId,this.awayImage,this.datetime,this.stadium,this.refree)
          ),

          //   PlayerDetails(this.id,this.name, this.image, this.club, this.position,
          //       this.nationality, this.age, this.matches, this.goals, this.assists, this.saves);
        );

      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(this.homeImage),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(this.home),
                          const SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                  child: Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          this.datetime,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            this.away,
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(this.awayImage),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );



  }


}

