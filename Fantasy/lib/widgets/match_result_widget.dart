import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MatchResult extends StatelessWidget  {

  String home;
  String homeImage;
  String away;
  String awayImage;
  String homeGoals;
  String awayGoals;
  String date;
  String time;

  MatchResult(this.home,this.homeGoals,this.homeImage,this.away,this.awayGoals,this.awayImage,this.date,this.time);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  Container(
                    height: 40,
                    width: 40,
                    child:
                    Image.network(this.homeImage,
                    ),
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
                  child:  Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                   child: Column(
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text(
                             this.homeGoals,
                             style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 18.0,
                               color: Colors.white,
                             ),
                           ),
                           Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0)),
                           const SizedBox(
                             height: 5.0,
                           ),
                           Text(
                             ":",
                             style: TextStyle(
                               fontWeight: FontWeight.bold,
                               fontSize: 18.0,
                               color: Colors.white,
                             ),
                           ),
                           Padding(padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0)),
                           const SizedBox(
                             height: 5.0,
                           ),
                           Text(
                             this.awayGoals,
                             style: TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 16.0,
                                 color: Colors.white),
                           ),
                         ],
                       ),
                       const SizedBox(
                         height: 5.0,
                       ),
                       Text(
                         this.date,
                         style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 16.0,
                             color: Colors.white),
                       ),

                     ],
                   )


                  ),
                )


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
                  Container(
                    height: 40,
                    width: 40,
                    child:
                    Image.network(this.awayImage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}