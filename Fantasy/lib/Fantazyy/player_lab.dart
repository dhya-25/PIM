/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */
import 'package:Fantasy/Fantazyy/player%20copy.dart';

class PlayerLab {
  List<Playerr> _players = [];
  static PlayerLab _sPlayerLab;

  static PlayerLab get() {
    if (_sPlayerLab == null) {
      throw "sPlayerLab is null";
    }
    return _sPlayerLab;
  }

  Future<void> addPlayer(Playerr player) async{
    _sPlayerLab.players.add(player);
  }

  Future <Playerr> getPlayer(int id) async{
    for (Playerr player in _players) {
      if (player.playerID == id) {
        return player;
      }
    }
    return null;
  }

  PlayerLab();

  PlayerLab.fromJson(List<dynamic> json) {
    _sPlayerLab = PlayerLab();
    for (Map<String, dynamic> playerJson in json) {
        addPlayer(Playerr.fromJson(playerJson));
      }
  }

  List<Playerr> get players => _players;

}
