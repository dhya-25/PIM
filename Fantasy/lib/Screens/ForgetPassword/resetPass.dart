import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:Fantasy/Screens/ForgetPassword/codeVerif.dart';
import 'package:Fantasy/Screens/Login/components/body.dart';
import 'package:Fantasy/Screens/Login/login_screen.dart';
import 'package:Fantasy/Screens/Signup/components/background.dart';
import 'package:Fantasy/components/rounded_button.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ResetPass extends StatefulWidget {
  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {

    TextEditingController password = TextEditingController();
        TextEditingController npassword = TextEditingController();
int id;

        updatePAss(String password) async {

          SharedPreferences prefs = await SharedPreferences.getInstance();
 id= prefs.getInt("userID");
 print(id);
    // set up POST request arguments
    String url = 'http://192.168.43.203:3000/api/users/updatepassword';
    Map<String, String> headers = {"Content-type": "application/json"};
       String json = '{"password": "' + password + '"}';
    
    Response response = await post(url, headers: headers, body: json+prefs.getInt("userID").toString());

    var res = jsonDecode(response.body);
    print(res);
     if(res == "updated"){
      Fluttertoast.showToast(
        msg: "Votre mot de passe est mettre a jour",
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
      appBar: AppBar(title: Text('Put your New Paasword'),
           backgroundColor: Colors.blue[300],
        elevation: 0.0,
                flexibleSpace: Container(decoration: 
        BoxDecoration(
          gradient: LinearGradient(colors: [Colors.purple ,Colors.red],
          begin: Alignment.bottomRight,
          end:Alignment.topLeft)
        ),
        ),
      ),
      body: Container(
                  decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Assets/bgg.jpg"),
              fit: BoxFit.cover
            )
          ),
        child: Column(

          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: password,
              //controller: user,
              decoration: InputDecoration(hintText: 'Enter Your password'),),
          ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: npassword,
              //controller: user,
              decoration: InputDecoration(hintText: 'Enter Your New password'),),
          ),
                   RaisedButton(
              color: Colors.purple,
              child: Text('Next',style: TextStyle(color: Colors.white),),
              onPressed: (){
               
                //login();
                updatePAss(npassword.text);
              },
            ),

          ],),
      ),
    );
  }
}