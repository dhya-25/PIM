import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:Fantasy/Screens/ForgetPassword/codeVerif.dart';
import 'package:http/http.dart';


class mailVerif extends StatefulWidget {
  @override
  _verifUserState createState() => _verifUserState();
}

class _verifUserState extends State<mailVerif> {

    TextEditingController email = TextEditingController();

    verifCode(String email) async {
    // set up POST request arguments
    String url = 'http://192.168.43.203:3000/api/users/verifyEmailForReset';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"email": "' + email + '"}';
    
    Response response = await post(url, headers: headers, body: json);

    var res = jsonDecode(response.body);
    print(res);
     if(res == "invalid"){
      Fluttertoast.showToast(
        msg: "code invalide",
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
        msg: "code invalide",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CodeVerif(),),);
  
    }
      return response;
    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Put your Mail'),
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

          children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: email,
              //controller: user,
              decoration: InputDecoration(hintText: 'Enter Your Mail'),),
          ),
                   MaterialButton(
              color: Colors.purple,
              child: Text('Next',style: TextStyle(color: Colors.white),),
              onPressed: (){
               
                //login();
                verifCode(email.text);
              },
            ),

          ],),
      ),
    );
  }
}