import 'package:flutter/material.dart';
import 'package:Fantasy/Fantazyy/clubFantazy.dart';


import 'team_display_view.dart';

import 'package:Fantasy/Fantazyy/squad_list.dart';


import 'package:flutter/material.dart';

import 'package:Fantasy/Fantazyy/loginFantasy.dart';


class TabBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, 
      child: Scaffold(
        appBar: AppBar(
          title: Text("Menu with Tabs"),
                backgroundColor: Colors.blue[300],
        elevation: 0.0,
                flexibleSpace: Container(decoration: 
        BoxDecoration(
          gradient: LinearGradient(colors: [Colors.purple ,Colors.red],
          begin: Alignment.bottomRight,
          end:Alignment.topLeft)
        ),
        ),
          bottom: TabBar(tabs: [
            Tab(
              text: "Edit Squad",
              icon: Icon(Icons.list),
            ),
          Tab(
              text: "Squad",
              icon: Icon(Icons.list),
            ),
             Tab(
              text: "Club Fantazy",
              icon: Icon(Icons.list),
            ),
          ]),
          actions: [
            IconButton(icon: Icon(Icons.exit_to_app),
            onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {return loginFantasy();}));

            },)
            ],
        ),

        body: TabBarView(children: [
          TeamDisplayView(),
          SquadList(),
          GetAllUsersScores()
        ]),
      ));
  }
}