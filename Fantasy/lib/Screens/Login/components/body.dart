import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/Profile/storage.dart';
import 'package:Fantasy/Screens/ForgetPassword/mailVerif.dart';
import 'package:Fantasy/Screens/Login/components/background.dart';
import 'package:Fantasy/Screens/Login/components/user_api.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Welcome.dart';
import '../../../constants.dart';

class login extends StatefulWidget {
  const login({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<login> {
      final SecureStorage secureStorage = SecureStorage();


  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

   

makePostRequest(String email, String password) async {
    // set up POST request arguments
    String url = '${ApiKey.url}/api/users/login';
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"email": "' + email + '", "password": "' + password + '"}';
      
    Response response = await post(url, headers: headers, body: json);
    String res = response.body;
    print(res);
    var parsed = jsonDecode(res);
    UserApi user = UserApi.fromJson(parsed);
    print(user.id);
    print(user.name);

    if(user.id == -1){
      Fluttertoast.showToast(
          msg: "Invalid Email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else if(user.id == -2){
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
      prefs.clear();
      prefs.setInt("userID",user.id);
      prefs.setString("userEmail",user.email);
      prefs.setString("userPassword",user.password);
      prefs.setString("userName",user.name);

      prefs.setInt("clubId",int.parse(user.equipe));
      print(user.equipe);
      Fluttertoast.showToast(
          msg: "login success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBarV2(),),);
    }

    return response;
    
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
                   ForgetPAss(
                       press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return mailVerif();
                        },
                      ),
                    );
                  },
                     
                   )  , 
                SizedBox(
                  height: 10,
                ),
                RoundedButton(
                  text: "LOGIN",
                  press: ()  {
                    
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
