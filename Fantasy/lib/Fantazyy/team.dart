/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

import 'package:Fantasy/Fantazyy/player%20copy.dart';

class Team {
   int _teamId;
   String _name;
  
   double _price;
   
   List<Playerr> _players = new List();


   Team(this._teamId, this._name, this._price, int _players);

   
String get name => _name;

  set names(String value) {
    _name = value;
  }
   
double get price => _price;

  set prices(double value) {
    _price = value;
  }
}