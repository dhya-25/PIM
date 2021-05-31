import 'package:flutter/cupertino.dart';
import 'package:Fantasy/clubs/Clubs.dart';
import 'package:Fantasy/clubs/club_details.dart';
import 'package:Fantasy/clubs/club_navigation_bar.dart';
import 'package:Fantasy/clubs/club_stats.dart';
import 'package:Fantasy/managers/manager_details.dart';
import 'package:Fantasy/players/Players.dart';
import 'package:Fantasy/players/player_details.dart';

class Routes {
  // Route name constants
  static const String PlayersList = '/players';
  //static const String PlayerDetail = '/details';
  //static const String ManagerDetail = '/managerdetails';
  static const String ClubMenu = '/clubmenu';
  //static const String ClubDetail = '/clubs';
  //static const String ClubStat = '/clubs/stats';

  /// The map used to define our routes, needs to be supplied to [MaterialApp]
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.PlayersList: (context) => Players(),
      //Routes.PlayerDetail: (context) => PlayerDetails(),
    //  Routes.ManagerDetail: (context) => ManagerDetails(),
      Routes.ClubMenu: (context) => ClubNavigationBar()
      //Routes.ClubDetail: (context) => ClubDetails(),
      //Routes.ClubStat: (context) => ClubStats()
    };
  }
}