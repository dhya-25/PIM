import 'package:flutter/material.dart';



class SampleDemo extends StatefulWidget {


  @override
  _SampleDemoState createState() => _SampleDemoState();
}

class _SampleDemoState extends State<SampleDemo> {
  TextEditingController _controller =
      TextEditingController(text: "Festive Leave");
  bool _isEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Row(
              children: <Widget>[
                Container(
                  width: 100,
                  child: TextField(
                    controller: _controller,
                    enabled: _isEnable,
                  ),
                ),
                RaisedButton(
                    onPressed: () {
                      setState(() {
                        _isEnable = true;
                      });
                    })
              ],
      ),
    );
  }
}
