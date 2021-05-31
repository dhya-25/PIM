import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/Profile/storage.dart';
import 'package:Fantasy/Screens/Login/login_screen.dart';
import 'package:Fantasy/Screens/Signup/components/background.dart';
import 'package:Fantasy/Screens/Signup/components/or_divider.dart';
import 'package:Fantasy/Screens/Signup/components/social_icon.dart';
import 'package:Fantasy/components/already_have_an_account_acheck.dart';
import 'package:Fantasy/components/rounded_button.dart';
import 'package:Fantasy/components/rounded_input_field.dart';
import 'package:Fantasy/components/rounded_password_field.dart';
import 'package:Fantasy/models/ListTeams.dart';
import 'package:Fantasy/verifUser.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Fantasy/verifUser.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:Fantasy/Screens/Login/components/user_api.dart';



class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

int _id; 

  String _namee;
  String _email;
  String _equipe;
  String _password;
UserApi user;

  String selected ;
  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController equipe = TextEditingController();
  TextEditingController password = TextEditingController();

  registerUser( String name, String email, String equipe, String password) async {
    String url = '${ApiKey.url}/api/users/adduser';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"name": "' +
        name +
        '","email": "' +
        email +
        '","equipe": "' +
        selected +
        '", "password": "' +
        password +
        '"}';
   Response response = await post(url, headers: headers, body: json);
    String res = response.body;
   Map parsed = jsonDecode(res);
    UserApi user = UserApi.fromJson(parsed); 
    print(user.id);
    print(user.name);
SharedPreferences prefs = await SharedPreferences.getInstance();
prefs.clear();
  prefs.setInt("userID",user.id);
    prefs.setString("userEmail",user.email);
  prefs.setString("userPassword",user.password);
    prefs.setString("userName",user.name);


    if (res == "Error") {
       

      Fluttertoast.showToast(
          msg: "You have already an acount",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

    } else {
      Fluttertoast.showToast(
          msg: "Verify your acount ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifUser(),),);


     
    }
    return response;
  }
     List   results ;

   Future<void>  getclubs() async {

    http.Response response = await http.get(
        'https://v3.football.api-sports.io/teams?season=2020&league=61',
        headers: {'x-rapidapi-key': "f6ebead51a2ade65b73948c623b1da95",
          'x-rapidapi-host':'v3.football.api-sports.io'});
    String body = response.body;
    var data = jsonDecode(body);

    setState(() {
      results = data['response'];
    });

  }


  @override
  void initState() {
    super.initState();
    getclubs();
  }

  @override
  Widget build(BuildContext context) {



    Size size = MediaQuery.of(context).size;
    return Scaffold(
          body: Container(
             decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Assets/bgg.jpg"),
              fit: BoxFit.cover
            )
          ),
                      child: Background(
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "SIGNUP",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(hintText: 'Name',),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: email,
                    decoration: InputDecoration(hintText: 'email'),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      value: selected,
                      hint: Text("Select your Team"),
                      onChanged: (String value) {
                                 selected = value;
                            getclubs();
                            print(selected);
                     
                      },
                      items: results?.map((item){
                        return DropdownMenuItem(
                          child: 
                            Text(item['team']['name']),
                            value: item['team']['id'].toString(),
                           
                          );
                      })?.toList()??
                      []
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: password,
                    decoration: InputDecoration(hintText: 'Password'),
                      obscureText: true,

                  ),
                ),
                RoundedButton(
                  text: "SIGNUP",
                  press: () async {
                    

                  SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("clubID",selected);


              
                    registerUser(name.text, email.text, selected, password.text);
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                ),
                OrDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocalIcon(
                      iconSrc: "assets/icons/facebook.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      iconSrc: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                    SocalIcon(
                      iconSrc: "assets/icons/google-plus.svg",
                      press: () {},
                    ),
                  ],
                )
              ],
            ),
        ),
      ),
          ),
    );
  }
}
