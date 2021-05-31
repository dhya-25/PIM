import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:Fantasy/Screens/Login/login_screen.dart';
import 'package:Fantasy/Screens/Welcome/components/body.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:Fantasy/Key/Key.dart';


class VerifUser extends StatefulWidget {
  @override
  _VerifUserState createState() => _VerifUserState();
}

class _VerifUserState extends State<VerifUser> {

    TextEditingController code = TextEditingController();
int id;
    verifCode(String code) async {

      SharedPreferences prefs = await SharedPreferences.getInstance();

   id= prefs.getInt("id");
   print(id);
    // set up POST request arguments
    String url = '${ApiKey.url}/api/users/verifcode';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"codeverification": "' + code + '","idUser": "' +
       "104" +
        '"}';
    
    Response response = await post(url, headers: headers, body: json);
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>Body(),),);

    var res = jsonDecode(response.body);
    print(res);
     if(res == "invalid"){
      Fluttertoast.showToast(
        msg: "code  validé",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );


    
  }
  else{
     Fluttertoast.showToast(
        msg: "code validé",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(),),);

    }
      return response;
    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Put your code'),
       flexibleSpace: Container(decoration: 
        BoxDecoration(
          gradient: LinearGradient(colors: [Colors.purple ,Colors.red],
          begin: Alignment.bottomRight,
          end:Alignment.topLeft)
        ),
        ),),
      body: Container(
                  decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Assets/bgg.jpg"),
              fit: BoxFit.cover
            )
          ),
        child: Column(

          children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: code,
              //controller: user,
              decoration: InputDecoration(hintText: 'Enter Your Code'),),
          ),
                   MaterialButton(
              color: Colors.indigo,
              child: Text('Verifier',style: TextStyle(color: Colors.white),),
              onPressed: (){
               
                //login();
                verifCode(code.text);
              },
            ),

          ],),
      ),
    );
  }
}