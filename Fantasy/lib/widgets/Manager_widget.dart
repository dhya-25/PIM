import 'package:flutter/material.dart';
import 'package:Fantasy/managers/manager_arguments.dart';
import 'package:Fantasy/managers/manager_details.dart';
import 'package:Fantasy/routes/Routes.dart';


class ManagerWidget extends StatelessWidget  {

  int id;
  String name;
  String lastname;
  String image;
  String club;
  String nationality;
  int clubid;

  ManagerWidget({this.id,this.name,this.lastname,this.image,this.club,this.nationality,this.clubid});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) =>  ManagerDetails( id: this.id, name: this.name, lastname: this.lastname, image:this.image, club:this.club, nationality: this.nationality,clubid: this.clubid,),
        ),
        );
      },
      child: Container(
        width: double.infinity,
        child:   Card(
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
                    Text(this.lastname, style: TextStyle( fontWeight:FontWeight.bold,
                      fontSize: 18.0,
                    )),
                    const SizedBox(height: 5.0, ),
                    Text("Club : "+this.club, style: TextStyle( fontWeight:FontWeight.bold,
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

