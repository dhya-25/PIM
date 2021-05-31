import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Fantasy/Fantazyy/Playerrs.dart';
import 'package:Fantasy/Fantazyy/club_api.dart';
import 'package:Fantasy/Fantazyy/create_team_view.dart';
import 'package:Fantasy/Fantazyy/player%20copy.dart';
import 'package:Fantasy/Fantazyy/player_lab.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:http/http.dart' as http;


class PlayersCreationDetailsView extends StatefulWidget {

  final List<Playerr> selectedPlayers;
  final int playerIndex;

  const PlayersCreationDetailsView ({
    Key key,
    @required this.selectedPlayers,
    @required this.playerIndex
  })  : super(key: key);

  @override
  _PlayersCreationDetailsViewState createState() => _PlayersCreationDetailsViewState();
}


class _PlayersCreationDetailsViewState extends State<PlayersCreationDetailsView> {
  bool _sortAsc = false;
  int _sortColumnIndex = 0;
  double _columnWidth  = 40.0;
  double _columnNameWidth  = 60.0;
  double _columnPosWidth  = 80.0;
  PlayersDataSource _playersDataSource;
  List<Playerr> _players = [];
  List<ClubApi> selectedClubs = [];
  List<int> clubIdentifiers = [];
  List<Playerrs> playersjson = [];
  List<Playerr> playersApi = [];
    List<dynamic> playerList ;
   List _table;


  int _rowsPerPage = 20;
   final String apiUrl =
      "https://v3.football.api-sports.io/players?season=2020&league=61";
  
  static const headers = {
    'x-rapidapi-host': "v3.football.api-sports.io",
    //Always make sure to check the api key and the limit of a request in a free api
    'x-rapidapi-key': ApiKey.key
  };

  void _sort<T>(Comparable<T> getField(Playerr p), int columnIndex, bool ascending) {
    _playersDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAsc = ascending ;
    });
  }


   getClubIds() async {
    http.Response response = await http.get(
        "https://v3.football.api-sports.io/teams?season=2020&league=61",
        headers: {'x-rapidapi-host': "v3.football.api-sports.io",
          'x-rapidapi-key': ApiKey.key});
    String body = response.body;
    var data = jsonDecode(body);
    List<dynamic> table = data['response'];

    setState(() {
      selectedClubs = table
          .map((dynamic item) => ClubApi.fromJson(item))
          .toList();

      for(var item in selectedClubs){
         clubIdentifiers.add(item.team.id);
      }

      for(int item in clubIdentifiers){
        print("club id"+item.toString());

        this.getPlayer(item);

      }

    });

  }


  Future<void> getPlayer(int id) async {
    http.Response response = await http.get(
        "https://v3.football.api-sports.io/players?season=2020&league=61&team=$id",
        headers: {'x-rapidapi-host': "v3.football.api-sports.io",
          'x-rapidapi-key': ApiKey.key});
    String body = response.body;
    var data = jsonDecode(body);
    List<dynamic> table = data['response'];

   if(mounted){
    setState(() {
      playersjson = table
          .map((dynamic item) => Playerrs.fromJson(item))
          .toList();

      for (var item in playersjson) {
        String pos = item.statistics[0].games.position.toString().substring(8);
        playersApi.add(Playerr(
            item.player.id,
            item.player.firstname,
            item.player.lastname,
            pos,
            item.statistics[0].team.name,
            item.statistics[0].team.id,
            item.statistics[0].games.rating,
            item.statistics[0].games.appearences,
            item.statistics[0].goals.total,
            item.statistics[0].goals.assists,
            item.statistics[0].goals.conceded,
            item.statistics[0].cards.red,
            item.statistics[0].cards.yellow,
            item.player.photo));
      }
      print(playersApi.length);


      if (widget.playerIndex < 2) {
        _players = playersApi.where((player) =>
            player.position.contains("GOALKEEPER")).toList();
      } else if (widget.playerIndex < 7) {
        _players =
            playersApi.where((player) => player.position.contains("DEFENDER"))
                .toList();
      } else if (widget.playerIndex < 12) {
        _players =
            playersApi.where((player) => player.position.contains("MIDFIELDER"))
                .toList();
      } else {
        _players = playersApi.where((player) => player.position.contains("ATTACKER"))
                .toList();
      }

      print("length of selected" + widget.selectedPlayers.length.toString());
      for (var item in widget.selectedPlayers) {
        print("selected" + item.toString());
        if (item == null) {
          print("hello");
        } else if (item != null) {
          print(item.playerID.toString());
          _players.removeWhere((player) => player.playerID == item.playerID);
        }
      }

      _playersDataSource = PlayersDataSource(
          widget.playerIndex, widget.selectedPlayers, _players, context);
    });
  }
  }

@override
  void initState() {
  super.initState();

  this.getClubIds();
    //filter out players by position

  }

  @override
  Widget build(BuildContext context) {
    print(playersApi.length);

    return  playersApi.length == 0
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
        : WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            PaginatedDataTable(
              columnSpacing: 1.0,
              horizontalMargin: 1.0,
              availableRowsPerPage: [10,20,50],
              rowsPerPage: _rowsPerPage,
              onRowsPerPageChanged: (int value) { setState(() { _rowsPerPage = value; }); },
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAsc,
              header: Text("Players"),
              columns: <DataColumn>[
                new DataColumn(
                    label: new Container(width: _columnPosWidth , child: Text("First Name", softWrap: true,)),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<String>((Playerr p) => p.firstName, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnPosWidth , child: Text("Last Name", softWrap: true,)),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<String>((Playerr p) => p.lastName, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnPosWidth , child: Text("Position", softWrap: true,)),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<String>((Playerr p) => p.position, columnIndex, ascending)
                ),
                  new DataColumn(
                    label: new Container(width: _columnPosWidth , child: new Text("Price")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Playerr p) => p.price, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnPosWidth , child: Text("Rating", softWrap: true,)),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<String>((Playerr p) => p.rating, columnIndex, ascending)
                ),

                new DataColumn(
                    label: new Container(width: _columnPosWidth , child: new Text("Team")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<String>((Playerr p) => p.team, columnIndex, ascending)
                ),
                
                new DataColumn(
                    label: new Container(width: _columnPosWidth , child: new Text("Apps")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Playerr p) => p.appearances, columnIndex, ascending)
                ),

                new DataColumn(
                    label: new Container(width: _columnPosWidth , child: new Text("Goals")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Playerr p) => p.goals, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnPosWidth , child: new Text("Assists")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Playerr p) => p.assists, columnIndex, ascending)
                ),
                
                new DataColumn(
                    label: new Container(width: _columnPosWidth , child: new Text("Clean")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Playerr p) => p.cleanSheets, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnPosWidth , child: new Text("Yellows")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Playerr p) => p.yellowCards, columnIndex, ascending)
                ),
                new DataColumn(
                    label: new Container(width: _columnPosWidth , child: new Text("Reds")),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) => _sort<num>((Playerr p) => p.redCards, columnIndex, ascending)
                ),
               
              ],
              source: _playersDataSource,
            )
          ],
        )
      )
    );
  }
}

class PlayersDataSource extends DataTableSource {

  PlayersDataSource(this._playerIndex, this._selectedPlayers, this._players, this.context);

  int _playerIndex;
  List<Playerr> _players;
  List<Playerr> _selectedPlayers;

  int _selectedCount = 0;
  var context;
  double _columnPosWidth  = 80.0;

  void _sort<T>(Comparable<T> getField(Playerr p), bool ascending) {
    _players.sort((Playerr a, Playerr b) {
      if (!ascending) {
        final Playerr c = a;
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
    return DataCell(Container(width: _columnPosWidth, child: Text(text, overflow: TextOverflow.fade, softWrap: false,)));
  }

  


  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _players.length)
      return null;
    final Playerr player = _players[index];
    return DataRow.byIndex(
      onSelectChanged: (bool) {
        _players.removeAt(index);
        _selectedPlayers[_playerIndex] = player;
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {return CreateTeamView(players: _players, selectedPlayers: _selectedPlayers,);}));
      },
        index: index,
        cells: <DataCell>[
          getCell(player.firstName),
          getCell(player.lastName),
          getCell(player.position),
         getCell('${player.price}'),
          getCell('${player.rating}'),
          getCell('${player.team}'),
          getCell('${player.appearances}'),
          getCell('${player.goals}'),
          getCell('${player.assists}'),
          getCell('${player.cleanSheets}'),
          getCell('${player.yellowCards}'),
          getCell('${player.redCards}'),
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