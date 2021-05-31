import 'package:flutter/material.dart';
import 'package:Fantasy/widgets/Manager_widget.dart';
import 'package:http/http.dart' as http;
import 'package:Fantasy/models/transfert_json.dart';


class Managers extends StatefulWidget  {

  @override
  _ManagersState createState() => _ManagersState();
}

class _ManagersState extends State<Managers> {
List<Coach> results = [];
//   Coach("Pep Guardiola", "https://tofoot.com/up/2020/09/pep-guardiola.jpg", "Manchester City","Spain"),
//   Coach("Ronald Koeman", "https://tofoot.com/up/2020/12/ronald-koeman-1.jpg", "FC Barcelona","Netherlands"),
// ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Managers"),
              backgroundColor: Colors.blue[300],
        elevation: 0.0,
                flexibleSpace: Container(decoration: 
        BoxDecoration(
          gradient: LinearGradient(colors: [Colors.black ,Colors.red],
          begin: Alignment.bottomRight,
          end:Alignment.topLeft)
        ),
        ),
      ),
      body:
      ListView.builder(
        itemBuilder: (context, index){
          return ManagerWidget(id:results[index].id,name:results[index].name,image:results[index].image, club:results[index].club, nationality:results[index].nationality);
        },
        itemCount: results.length,
      ),

      );

  }
}


class Coach {

  int id;
  String name;
  String image;
  String club;
  String nationality;

  Coach(this.id,this.name,this.image,this.club,this.nationality);

}
