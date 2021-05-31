import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:Fantasy/Screens/ForgetPassword/resetPass.dart';
import 'package:Fantasy/Screens/Login/components/body.dart';
import 'package:http/http.dart';


class CodeVerif extends StatefulWidget {
  @override
  _CodeVerifState createState() => _CodeVerifState();
}

class _CodeVerifState extends State<CodeVerif> {

    TextEditingController code = TextEditingController();

    verifCode(String code) async {
    // set up POST request arguments
    String url = 'http://192.168.43.203:3000/api/users/verify_user_forReset';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"code": "' + code + '"}';
    
    Response response = await post(url, headers: headers, body: json);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>login(),),);

    var res = jsonDecode(response.body);
    print(res);
     if(res == "invalid"){
      Fluttertoast.showToast(
        msg: "code valide",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
     
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPass(),),);

  }

      return response;
    }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Put your Code'),
            backgroundColor: Colors.blue[300],
        elevation: 0.0,
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
              color: Colors.purple,
              child: Text('Next',style: TextStyle(color: Colors.white),),
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