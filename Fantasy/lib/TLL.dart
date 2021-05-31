import 'package:flutter/material.dart';
import 'package:Fantasy/tl/tl.dart';
import 'package:shared_preferences/shared_preferences.dart';



class TLL extends StatefulWidget {





  @override
  _TLLState createState() => _TLLState();
}



class _TLLState extends State<TLL> {
  int clubid;

   getClub() async {
    super.initState();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.clubid= prefs.getInt("clubId");
    });

  }


  @override
   void initState()  {

    this.getClub();

  }



  @override
  Widget build(BuildContext context) {

   print(clubid);

   return this.clubid == 0
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
   

        body:
        TL(this.clubid),
      );
  }
}