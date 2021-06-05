

import 'package:flutter/material.dart';
import 'package:Fantasy/Fantazyy/bodyFantazy.dart';
import 'package:Fantasy/Fantazyy/create_team_view.dart';
import 'package:Fantasy/Latestt.dart';
import 'package:Fantasy/Profile/storage.dart';
import 'package:Fantasy/Welcome.dart';
import 'package:Fantasy/settings.dart';
import 'package:Fantasy/tll.dart';
import 'package:Fantasy/Fantazyy/create_team_view.dart';
import 'package:Fantasy/stats/statss.dart';




String finalemail,finalName,finalEquipe,finalPass;
class BottomNavBarV2 extends StatefulWidget {
  @override
  _BottomNavBarV2State createState() => _BottomNavBarV2State();
}

class _BottomNavBarV2State extends State<BottomNavBarV2> {
int _bottomIndex = 0;
    List<Widget> interfaces = [latestt(),TLL(),BodyFantasy(),Statss() ,SettingsPage()];



  

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async => false,
    child: Scaffold(
      backgroundColor: Colors.white.withAlpha(55),
            bottomNavigationBar: BottomNavigationBar(
              
        items: [
        BottomNavigationBarItem(
                backgroundColor: Colors.black.withAlpha(55),

          label: "Latest",
          icon: Icon(Icons.book),
          ),
        BottomNavigationBarItem(
          label: "FR",
          icon: Icon(Icons.edit)
          ),
          BottomNavigationBarItem(
          label: "Fantazy",
          icon: Icon(Icons.book_online),
          ),
          BottomNavigationBarItem(
          label: "Stats",
          icon: Icon(Icons.sentiment_satisfied_alt_outlined),
          ),
          BottomNavigationBarItem(
          label: "More",
          icon: Icon(Icons.more),
          ),
      ],
      currentIndex: _bottomIndex,
      onTap: (int value){
        setState(() {
          _bottomIndex = value;
        });
      },
      ),
      body:
       interfaces[_bottomIndex],

    ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20), radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
} 