import 'dart:convert';

import 'package:Fantasy/LAtest/soccermodel.dart';
import 'package:http/http.dart';

class SoccerApi {
 
  final String apiUrl =
      "https://v3.football.api-sports.io/fixtures?season=2020&league=39";
  
  static const headers = {
    'x-rapidapi-host': "v3.football.api-sports.io",
    //Always make sure to check the api key and the limit of a request in a free api
    'x-rapidapi-key': "f6ebead51a2ade65b73948c623b1da95"
  };

  
  Future<List<SoccerMatch>> getAllMatches() async {
    Response res = await get(apiUrl, headers: headers);
    var body;

    if (res.statusCode == 200) {
      // this mean that we are connected to the data base
      body = jsonDecode(res.body);
      List<dynamic> matchesList = body['response'];
      print("Api service: ${body}"); // to debug
      List<SoccerMatch> matches = matchesList
          .map((dynamic item) => SoccerMatch.fromJson(item))
          .toList();

      return matches;
    }
  }
}
