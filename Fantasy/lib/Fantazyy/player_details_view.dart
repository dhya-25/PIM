/*
 * Copyright 2018 Leszek Nowaczyk. All rights reserved.
 * If you get hold of this code you probably found it on github ;)
 */

import 'package:flutter/material.dart';
import 'package:Fantasy/Fantazyy/player%20copy.dart';

class PlayerDetailsView extends StatelessWidget {
  final Playerr _p;

  PlayerDetailsView(this._p);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_p.fullName),
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
      body: Column(children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
              child: Column(
                children: <Widget>[
                  Text(
                    _p.fullName,
                    style: TextStyle(color: Colors.black87, fontSize: 20),
                  ),
                  /*Text(
                    _p.position + ' in the ' + _p.teamAsString + ' team',
                    style: TextStyle(color: Colors.black87, fontSize: 20),
                  ),*/
                ],
              )),
        ),
        Row(
          children: <Widget>[
            Image.asset(
              _p.image,
              height: 200.0,
            ),
            Column(
              children: <Widget>[
                getStatText('Apps', _p.appearances.toString()),
                getStatText('Goals', _p.goals.toString()),
                getStatText('Assists', _p.assists.toString()),
                getStatText('CSs', _p.cleanSheets.toString()),
                getStatText('Yellow Cards', _p.yellowCards.toString()),
                getStatText('Red Cards', _p.redCards.toString()),
              ],
            )
          ],
        ),
      ]),
    );
  }

  Widget getStatText(String text, String stat) {
    return new RichText(
      text: new TextSpan(
        style: new TextStyle(
          fontSize: 14.0,
          color: Colors.black87,
        ),
        children: <TextSpan>[
          new TextSpan(
              text: text + ': ',
              style: new TextStyle(fontWeight: FontWeight.bold)),
          new TextSpan(text: stat),
        ],
      ),
    );
  }
}
