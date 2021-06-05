import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Fantasy/Fantazyy/club_api.dart';
import 'package:Fantasy/Fantazyy/club_fantazy_model.dart';
import 'package:Fantasy/Fantazyy/club_update.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'get_fixtures_results.dart';


class GetAllUsersScores extends StatefulWidget {

  List<Datums> selectedPlayers = [];
  int playerIndex;

  @override
  _GetAllUsersScoresState createState() => _GetAllUsersScoresState();
}

class _GetAllUsersScoresState extends State<GetAllUsersScores> {
  int clubid;
  bool _sortAsc = false;
  int _sortColumnIndex = 0;
  double _columnPosWidth = 120.0;
  PlayersDataSource _playersDataSource;
  UsersClassements club;
  List<Datums> _players = [];
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


  void _sort<T>(
      Comparable<T> getField(Datums p), int columnIndex, bool ascending) {
    _playersDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAsc = ascending;
    });
  }


  Future<void> getUsersClassements() async {
    // set up POST request arguments
    String url = '${ApiKey.url}/api/questions/getallscores';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"clubid": "' + "aa" + '"}';
    Response response = await post(url, headers: headers, body: json);
    String res = response.body;
    Map parsed = jsonDecode(res);
    setState(() {
      club = UsersClassements.fromJson(parsed);
      for (var item in club.data) {
        _players.add(Datums(points:item.points,id:item.id,email:item.email,name:item.name,username:item.username));
          print("club name  "+item.name);
      }
      for (var item in _players) {
        print("club name players "+item.name);
      }
      _playersDataSource = PlayersDataSource(
          widget.playerIndex, widget.selectedPlayers, _players, context);
    });
  }

  @override
  void initState() {
    super.initState();
   this.getUsersClassements();
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
              header: Text("Fantazy Club Classements"),
              columns: <DataColumn>[
                new DataColumn(
                    label: new Container(
                        width: _columnPosWidth,
                        child: Text(
                          "Club Name",
                          softWrap: true,
                        )),
                   ),
                new DataColumn(
                    label: new Container(
                        width: _columnPosWidth,
                        child: Text(
                          "User Name",
                          softWrap: true,
                        )),
                    numeric: true,
                    onSort: (int columnIndex, bool ascending) =>
                        _sort<String>((Datums p) => p.username,
                            columnIndex, ascending)),

                new DataColumn(
                  label: new Container(
                      width: _columnPosWidth,
                      child: Text(
                        "Points",
                        softWrap: true,
                      )),
          numeric: true,
         onSort: (int columnIndex, bool ascending) =>
        _sort<String>((Datums p) => p.points.toString(),
        columnIndex, ascending)),
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
  List<Datums> _players;
  List<Datums> _selectedPlayers;

  int _selectedCount = 0;
  var context;
  double _columnPosWidth = 120.0;

  void _sort<T>(Comparable<T> getField(Datums p), bool ascending) {
    _players.sort((Datums a,Datums b) {
      if (!ascending) {
        final Datums c = a;
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
        padding: EdgeInsets.only(left: 1.0),
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
    final Datums player = _players[index];
    return DataRow.byIndex(
        index: index,
        cells: <DataCell>[
          getCell(player.name),
          getCell(player.username),
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