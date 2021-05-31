import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Fantasy/Fantazyy/Playerrs.dart';
import 'package:Fantasy/Fantazyy/club_api.dart';
import 'package:Fantasy/Fantazyy/club_update.dart';
import 'package:Fantasy/Fantazyy/create_team_view.dart';
import 'package:Fantasy/Fantazyy/player%20copy.dart';
import 'package:Fantasy/Fantazyy/player_lab.dart';
import 'package:Fantasy/Fantazyy/player_squad_json.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'club_edit.dart';
import 'get_fixtures_results.dart';

class SquadList extends StatefulWidget {
  List<PlayerSquad> selectedPlayers = [];
  int playerIndex;

  @override
  _SquadListState createState() => _SquadListState();
}

class _SquadListState extends State<SquadList> {
  int clubid;
  bool _sortAsc = false;
  int _sortColumnIndex = 0;
  double _columnWidth = 40.0;
  double _columnNameWidth = 60.0;
  double _columnPosWidth = 80.0;
  PlayersDataSource _playersDataSource;
  ClubSquadJson club;
  List<PlayerSquad> _players = [];
  List<ClubApi> selectedClubs = [];
  List<int> clubIdentifiers = [];
  List<GetFixturesResults> playersjson = [];
  List<PlayerUpdate> playersApi = [];
  List<PlayerUpdate> playersFilter = [];
  int clubidsd;
  List<dynamic> playerList;
  List<PlayerElement> playerElements= [];
  List<Statisticc> playerstats = [];
  List _table;

  int _rowsPerPage = 20;
  final String apiUrl =
      "https://v3.football.api-sports.io/players?season=2020&league=61";

  static const headers = {
    'x-rapidapi-host': "v3.football.api-sports.io",
    //Always make sure to check the api key and the limit of a request in a free api
    'x-rapidapi-key': ApiKey.key
  };

  void _sort<T>(
      Comparable<T> getField(PlayerSquad p), int columnIndex, bool ascending) {
    _playersDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAsc = ascending;
    });
  }

  getClubIds() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      clubidsd = prefs.getInt("clubID");
      print("clubid"+clubidsd.toString());
    });

    getPlayer(clubidsd);
  }

  Future<void>  getPlayerStats(int fixture, int teamid, int playerid) async {
    http.Response response = await http.get(
        'https://v3.football.api-sports.io/fixtures/players?fixture=$fixture&team=$teamid',
        headers: {'x-rapidapi-key': ApiKey.key,
          'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    var data = jsonDecode(body);
    List<dynamic> clubList = data['response'][0]['players'];

    setState(() {
      playerElements = clubList
          .map((dynamic item) => PlayerElement.fromJson(item))
          .toList();

     for(var item in playerElements){
       playersApi.add(PlayerUpdate(id: item.player.id ,firstname: item.player.name,lastname: item.player.name,position: item.statistics[0].games.position.toString(),price: 0,
           rating: item.statistics[0].games.rating,appearences:1 ,goals:item.statistics[0].goals.total ,assists: item.statistics[0].goals.assists ,cleansheets: item.statistics[0].goals.saves,
           redcards: item.statistics[0].cards.red,yellowcards: item.statistics[0].cards.yellow,image: item.player.photo,teamid: teamid ,clubid: clubid,fixtureid: fixture));

     }

       playersFilter.addAll(playersApi.where((player) =>
       player.id == playerid).toList());


    print("Filter length"+playersFilter.length.toString());
     for(var item in playersFilter){
       print("filterid:  "+item.id.toString());
       print("filter name : "+item.firstname.toString());
     }
      print("Filter length"+playersFilter.length.toString());
    });
  }

  Future<void> getPlayer(int ide) async {
    // set up POST request arguments
    String url = '${ApiKey.url}/api/questions/getclub';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"clubid": "' + ide.toString() + '"}';
    Response response = await post(url, headers: headers, body: json);
    String res = response.body;
    Map parsed = jsonDecode(res);


    setState(() {
      club = ClubSquadJson.fromJson(parsed);
      for (var item in club.data.players) {
        String rnd = item.round.substring(8);
        _players.add(PlayerSquad(
            id:item.id,
            firstname:item.firstname,
            lastname:item.lastname,
            position:item.position,
            price:item.price,
            appearences:item.appearences,
            rating:item.rating,
            teamid:item.teamid,
            goals:item.goals,
            assists:item.assists,
            cleansheets:item.cleansheets,
            redcards:item.redcards,
            yellowcards:item.yellowcards,
            image:item.image,
            clubid:item.clubid,
            round:rnd,
            fixtureid:item.fixtureid,
            points:item.points
        ));
      }
      _playersDataSource = PlayersDataSource(
          widget.playerIndex, widget.selectedPlayers, _players, context);
    });
  }

  @override
  void initState() {
    super.initState();
    this.getClubIds();
    //filter out players by position
  }

  @override
  Widget build(BuildContext context) {

    print(_players.length);

    return _players.length == 0
        ? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFFe70066),
                ),
              ),
            ),
          )
        : Scaffold(
          
            body: ListView(
              children: <Widget>[
                PaginatedDataTable(
                  columnSpacing: 1.0,
                  horizontalMargin: 1.0,
                  availableRowsPerPage: [10, 20, 50],
                  rowsPerPage: _rowsPerPage,
                  onRowsPerPageChanged: (int value) {
                    setState(() {
                      _rowsPerPage = value;
                    });
                  },
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAsc,
                  header: Text("Players"),
                  columns: <DataColumn>[
                    new DataColumn(
                        label: new Container(
                            width: _columnPosWidth,
                            child: Text(
                              "Image",
                              softWrap: true,
                            )),

                       ),
                    new DataColumn(
                        label: new Container(
                            width: _columnPosWidth,
                            child: Text(
                              "First Name",
                              softWrap: true,
                            )),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((PlayerSquad p) => p.firstname,
                                columnIndex, ascending)),
                    new DataColumn(
                        label: new Container(
                            width: _columnPosWidth,
                            child: Text(
                              "Last Name",
                              softWrap: true,
                            )),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((PlayerSquad p) => p.lastname,
                                columnIndex, ascending)),
                    new DataColumn(
                        label: new Container(
                            width: _columnPosWidth,
                            child: Text(
                              "Position",
                              softWrap: true,
                            )),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((PlayerSquad p) => p.position,
                                columnIndex, ascending)),
                    new DataColumn(
                        label: new Container(
                            width: _columnPosWidth, child: new Text("Price")),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) => _sort<num>(
                            (PlayerSquad p) => p.price, columnIndex, ascending)),
                    new DataColumn(
                        label: new Container(
                            width: _columnPosWidth,
                            child: Text(
                              "Rating",
                              softWrap: true,
                            )),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) =>
                            _sort<String>((PlayerSquad p) => p.rating, columnIndex,
                                ascending)),

                    new DataColumn(
                        label: new Container(
                            width: _columnPosWidth, child: new Text("Apps")),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) => _sort<num>(
                            (PlayerSquad p) => p.appearences,
                            columnIndex,
                            ascending)),
                    new DataColumn(
                        label: new Container(
                            width: _columnPosWidth, child: new Text("Goals")),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) => _sort<num>(
                            (PlayerSquad p) => p.goals, columnIndex, ascending)),
                    new DataColumn(
                        label: new Container(
                            width: _columnPosWidth, child: new Text("Assists")),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) => _sort<num>(
                            (PlayerSquad p) => p.assists, columnIndex, ascending)),
                    new DataColumn(
                        label: new Container(
                            width: _columnPosWidth, child: new Text("Clean")),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) => _sort<num>(
                            (PlayerSquad p) => p.cleansheets,
                            columnIndex,
                            ascending)),
                    new DataColumn(
                        label: new Container(
                            width: _columnPosWidth, child: new Text("Yellows")),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) => _sort<num>(
                            (PlayerSquad p) => p.yellowcards,
                            columnIndex,
                            ascending)),
                    new DataColumn(
                        label: new Container(
                            width: _columnPosWidth, child: new Text("Reds")),
                        numeric: true,
                        onSort: (int columnIndex, bool ascending) => _sort<num>(
                            (PlayerSquad p) => p.redcards, columnIndex, ascending)),
                    new DataColumn(
                        label: new Container(
                            width: _columnPosWidth,
                            child: Text(
                              "Round",
                              softWrap: true,
                            )),
                  ),

                    new DataColumn(
                      label: new Container(
                          width: _columnPosWidth,
                          child: Text(
                            "Points",
                            softWrap: true,
                          )),
                    ),

                  ],
                  source: _playersDataSource,
                )
              ],
            ));
  }
}

class PlayersDataSource extends DataTableSource {
  PlayersDataSource(
      this._playerIndex, this._selectedPlayers, this._players, this.context);

  int _playerIndex;
  List<PlayerSquad> _players;
  List<PlayerSquad> _selectedPlayers;

  int _selectedCount = 0;
  var context;
  double _columnPosWidth = 80.0;

  void _sort<T>(Comparable<T> getField(PlayerSquad p), bool ascending) {
    _players.sort((PlayerSquad a, PlayerSquad b) {
      if (!ascending) {
        final PlayerSquad c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  DataCell getCell(String text) {
    return DataCell(Container(
        width: _columnPosWidth,
        child: Text(
          text,
          overflow: TextOverflow.fade,
          softWrap: false,
        )));
  }

  DataCell getCellImage(String text) {
    return DataCell(Container(
        width: _columnPosWidth,
        child: Container(
          height: 40,
          width: 40,
          child:
          Image.network(text,
          ),
        ),

    ));
  }
  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _players.length)
      return null;
    final PlayerSquad player = _players[index];
    return DataRow.byIndex(
        index: index,
        cells: <DataCell>[
          getCellImage(player.image),
          getCell(player.firstname),
          getCell(player.lastname),
          getCell(player.position),
          getCell('${player.price}'),
          getCell('${player.rating}'),
          getCell('${player.appearences}'),
          getCell('${player.goals}'),
          getCell('${player.assists}'),
          getCell('${player.cleansheets}'),
          getCell('${player.yellowcards}'),
          getCell('${player.redcards}'),
          getCell('${player.round}'),
          getCell('     ${player.points}'),

        ]
    );
  }

  @override
  int get rowCount => _players.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

}