import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Fantasy/Fantazyy/get_fixtures.dart';
import 'package:Fantasy/Fantazyy/insert_fixture.dart';
import 'package:Fantasy/Fantazyy/see_results.dart';
import 'package:Fantasy/Fantazyy/squad_list.dart';
import 'package:Fantasy/Fantazyy/team_display_view.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/Profile/storage.dart';
import 'package:Fantasy/Screens/ForgetPassword/mailVerif.dart';
import 'package:Fantasy/Screens/Login/components/background.dart';
import 'package:Fantasy/Screens/Signup/signup_screen.dart';
import 'package:Fantasy/bottomNavig.dart';
import 'package:Fantasy/components/ForgetPass.dart';
import 'package:Fantasy/components/already_have_an_account_acheck.dart';
import 'package:Fantasy/components/rounded_button.dart';
import 'package:Fantasy/components/rounded_input_field.dart';
import 'package:Fantasy/components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:Fantasy/Profile/storage.dart';
import 'package:Fantasy/Screens/ForgetPassword/mailVerif.dart';
import 'package:Fantasy/Screens/Signup/signup_screen.dart';
import 'package:Fantasy/bottomNavig.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:Fantasy/Fantazyy/club_v2.dart';
import 'package:Fantasy/Fantazyy/bottom_nav.dart';

import 'package:shared_preferences/shared_preferences.dart';




class loginFantasy extends StatefulWidget {
  const loginFantasy({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<loginFantasy> {
      final SecureStorage secureStorage = SecureStorage();


  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();




  makePostRequest(String email, String password) async {
    // set up POST request arguments
    String url = '${ApiKey.url}/api/users/loginFantazy';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"email": "' + email + '", "password": "' + password + '"}';
      
    Response response = await post(url, headers: headers, body: json);
    String res = response.body;
    var parsed = jsonDecode(res);
    ClubV2 club = ClubV2.fromJson(parsed);
    if(club.userid == -1){
      Fluttertoast.showToast(
          msg: "Invalid Email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else if(club.userid == -2){
      Fluttertoast.showToast(
          msg: "Invalid Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt("clubID",club.id);
      Fluttertoast.showToast(
          msg: "login success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {return TabBarWidget();}));
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>TeamDisplayView(),),);
    }

    return response;
    
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   // secureStorage.writeSecureData("name", name.text);
    secureStorage.writeSecureData("email", email.text);
    //secureStorage.writeSecureData("equipe", equipe.text);
   // secureStorage.writeSecureData("password", password.text);
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
                  "LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),
                ),
                SizedBox(height: size.height * 0.03),
                /*SvgPicture.asset(
                  "assets/icons/login.svg",
                  height: size.height * 0.35,
                ),*/
                SizedBox(height: size.height * 0.03),
                 TextFormField(
                   controller: email,
                  decoration: InputDecoration(

                      border: OutlineInputBorder(), labelText: "Email"),
                       validator: (value){
                        if(value.isEmpty)
                        return "description cannot be empty";
                      },
                    
                ),
                    TextFormField(
                   controller: pass,
                  decoration: InputDecoration(

                      border: OutlineInputBorder(), labelText: "Password"),
                   obscureText: true,

                       validator: (value){
                        if(value.isEmpty)
                        return "description cannot be empty";
                      },
                    
                ),
                 SizedBox(
                  height: 10,
                ),
         
                SizedBox(
                  height: 10,
                ),
                RoundedButton(
                  text: "LOGIN",
                  press: () {
                    makePostRequest(email.text, pass.text);
                  },
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
        ),
      ),
          ),
    );
  }
}