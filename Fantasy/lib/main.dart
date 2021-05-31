import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Fantasy/Screens/Welcome/welcome_screen.dart';
import 'package:Fantasy/bottomNavig.dart';
import 'package:Fantasy/routes/Routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

 void main() async{
   /*MaterialApp(
   home: MyApp(),
   debugShowCheckedModeBanner: false,
   theme: AppTheme.lightTheme,
   darkTheme: AppTheme.darkTheme,
  ),*/
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences  prefs = await SharedPreferences.getInstance();
var email = prefs.getString("userEmail");
print(email);
runApp(MaterialApp(
        debugShowCheckedModeBanner: false,

   routes: Routes.getRoutes(),

   
home: email== null ? MyApp() : BottomNavBarV2(),
)
);
 }
 class MyApp extends StatefulWidget {
   @override
   _MyAppState createState() => _MyAppState();
 }
 
 class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
   Animation<double> animation;
   AnimationController controller;

   @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Duration(seconds: 1), vsync: this);
    final CurvedAnimation curve = CurvedAnimation(parent: controller, curve: Curves.ease);
    animation = Tween(begin: 1.0, end: 0.2).animate(curve);
    animation.addStatusListener((status) {
      if(status == AnimationStatus.completed)
      controller.reverse();
      else if(status == AnimationStatus.dismissed) controller.forward();
    });
    controller.forward();
    Timer(
      Duration(seconds: 5),
      () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => WelcomeScreen())),
      );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  
   @override
   Widget build(BuildContext context) {
     //Provider.of<ThemeNotifier>(context).loadThemeData(context);

     var logoUri = new AssetImage('Assets/logooo.png');
     var logoImage = new Image(image: logoUri, height: 250.0,);

     //var ballsUri = new AssetImage('assets/balls.png');
     //var ballsImage = new Image(image: ballsUri, height: 148.0,);
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
      )); 

     return Scaffold(
       body: Stack(
         fit: StackFit.expand,
         children: <Widget>[
           Container(
             decoration: BoxDecoration(
               color: new Color(0xffF7931D),
               gradient: LinearGradient(
                 colors: [new Color(0x000000),new Color(0xffFBC688)]
               ),
             ),
           ),
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FadeTransition(
                        opacity: animation,
                        child: logoImage,
                      ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        FadeTransition(
                          opacity: animation,
                          child: Text(
                            'FR Fantasy',
                            style: TextStyle(fontFamily: 'Montserrat', fontSize: 53.0, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                          ),
                        ),
                        /*Padding(
                          padding: EdgeInsets.only(top: 20.0),
                        ),
                        CircularProgressIndicator(backgroundColor: Colors.transparent, valueColor: new AlwaysStoppedAnimation<Color>(Color(0xffF3F3F3)),),*/

                    ],
                  ),
                ),
              ),
              /*Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ballsImage,
                  ],
                ),
              )*/
             ],
           ),
         ],
       ),
     );
   }
 }