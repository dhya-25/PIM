import 'dart:convert';

import 'package:Fantasy/Fantazyy/player%20copy.dart';
import 'package:Fantasy/Fantazyy/player_lab.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/LAtest/soccermodel.dart';
import 'package:http/http.dart';

class SoccerApi {
 
  final String apiUrl =
      "https://v3.football.api-sports.io/players?season=2020&league=61";
  
  static const headers = {
    'x-rapidapi-host': "v3.football.api-sports.io",
    //Always make sure to check the api key and the limit of a request in a free api
    'x-rapidapi-key': ApiKey.key
  };

  
  Future<List<Playerr>> getAllPlayers() async {
    Response res = await get(apiUrl, headers: headers);
    var body;

    if (res.statusCode == 200) {
      // this mean that we are connected to the data base
      body = jsonDecode(res.body);

      List<dynamic> playerList = body['response'];
      print("Api service: ${body}"); // to debug
      List<Playerr> player = playerList
          .map((dynamic item) => Playerr.fromJson(item))
          .toList();
       PlayerLab.fromJson(playerList);

      return player;
    }
  }
}
