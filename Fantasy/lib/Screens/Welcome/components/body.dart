import 'package:flutter/material.dart';
import 'package:Fantasy/Screens/Login/login_screen.dart';
import 'package:Fantasy/Screens/Signup/signup_screen.dart';
import 'package:Fantasy/Screens/Welcome/components/background.dart';
import 'package:Fantasy/components/rounded_button.dart';
import 'package:Fantasy/constants.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
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
                  "Welcome To FR Fantazy",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,  fontSize: 25,
),
                ),
                SizedBox(height: size.height * 0.05),
                /*SvgPicture.asset(
                  "assets/icons/chat.svg",
                  height: size.height * 0.45,
                ),*/
                SizedBox(height: size.height * 0.05),
                RoundedButton(
                  text: "LOGIN",
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
                RoundedButton(
                  text: "SIGN UP",
                  color: kPrimaryLightColor,
                  textColor: Colors.black,
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
