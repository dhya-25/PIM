import 'package:Fantasy/clubs/club_arguments.dart';
import 'package:flutter/material.dart';
import 'package:Fantasy/clubs/club_arguments.dart';
import 'package:Fantasy/clubs/club_details.dart';
import 'package:Fantasy/clubs/club_squad.dart';
import 'package:Fantasy/clubs/club_stats.dart';
import 'package:Fantasy/routes/Routes.dart';

class ClubNavigationBar extends StatefulWidget {

  ClubNavigationBar ({Key key}) : super(key: key);

  @override
  _ClubNavigationBarState createState() => _ClubNavigationBarState();
}

class _ClubNavigationBarState extends State<ClubNavigationBar > {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Club Info', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Players', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Season Results', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index) {
    setState(() {
      final ClubArguments args = ModalRoute.of(context).settings.arguments;
      print(args.id);
      print("aaaaaaaa");
      _selectedIndex = index;
        switch (index) {
          case 0:
            Navigator.push(
              context,
                MaterialPageRoute(
                  builder: (context) =>  ClubDetails(id: args.id,name: args.name ,image: args.image ,rank: args.rank,nationality: args.nationality
                    ,stadium: args.stadium ,manager: args.manager ,wins: args.wins
                    ,draws: args.draws ,losses: args.losses,goals: args.goals,goalsIn: args.goalsIn,),
                ),
              //arguments: ClubArguments(args.id,args.name, args.image, args.rank, args.nationality, args.stadium, args.manager,args.wins,args.draws,args.losses,args.goals,args.goalsIn)
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  ClubPlayers(clubId: args.id),
              ),
              //arguments: ClubArguments(args.id,args.name, args.image, args.rank, args.nationality, args.stadium, args.manager,args.wins,args.draws,args.losses,args.goals,args.goalsIn)
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  ClubStats(id: args.id,name: args.name ,image: args.image ,rank: args.rank,nationality: args.nationality
                  ,stadium: args.stadium ,manager: args.manager ,wins: args.wins
                  ,draws: args.draws ,losses: args.losses,goals: args.goals,goalsIn: args.goalsIn,),
              ),
              //arguments: ClubArguments(args.id,args.name, args.image, args.rank, args.nationality, args.stadium, args.manager,args.wins,args.draws,args.losses,args.goals,args.goalsIn)
            );
            break;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Club Menu'),
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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Assets/bg.jpg"),
              fit: BoxFit.cover
            )
          ),
              child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Club Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_football),
            label: 'Players',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_bar_chart),
            label: 'Stats',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
    onTap: _onItemTapped
      ),
    );
  }


}