import 'dart:async';
import 'dart:convert';
import 'package:Fantasy/Key/Key.dart';
import 'package:Fantasy/Screens/Login/components/user_api.dart';
import 'package:Fantasy/settings.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsUI extends StatefulWidget {
  @override
  _SettingsUIState createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
final String url = "${ApiKey.url}/api/users/";

  bool isEditable=false;
  List results;
    String selected ;
    String name
,email,pass;
  List<UserApi> users =[];
int id;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getJsonData();
  }
  getJsonData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
name =prefs.getString("userName");
email =prefs.getString("userEmail");
pass =prefs.getString("userPassword");
print(name);
print(email);
print(pass);
  
    return "Success";
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue[300],
        elevation: 0.0,
                flexibleSpace: Container(decoration: 
        BoxDecoration(
          gradient: LinearGradient(colors: [Colors.black ,Colors.red],
          begin: Alignment.bottomRight,
          end:Alignment.topLeft)
        ),
        ),
          leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
         },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),

      ),
      body:
          Container(
             decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Assets/bg.jpg"),
              fit: BoxFit.cover
            )
          ),
                      child: 
              
              
               Column(
                              children: [
                                      Row(
                    children: [
        Expanded(
              child: !isEditable
                    ? Text(name)
                    : TextFormField(
                        initialValue: name,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          setState(() => {isEditable = false, name = value});
                        })),
    
      ]),
      Row(
                    children: [
        Expanded(
              child: !isEditable
                    ? Text(email)
                    : TextFormField(
                        initialValue: email,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          setState(() => {isEditable = false, email = value});
                        })),
        IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() => {
                      isEditable = true,
                    });
            },
        )
      ]),

      // Row(
      //               children: [
      //   Expanded(
      //         child: !isEditable
      //               ? Text("pass")
      //               : TextFormField(
      //                   initialValue: pass,
      //                   textInputAction: TextInputAction.done,
      //                                     obscureText: true,

      //                  )),
   
      // ]),



      
    ],
               ),
           
   
       
           
        
          ),
    );
  }
  

  


  }



// import 'dart:async';
// import 'dart:convert';
// import 'package:footyappp/Screens/Login/components/user_api.dart';
// import 'package:footyappp/settings.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';


// class SettingsUI extends StatefulWidget {
//   @override
//   _SettingsUIState createState() => _SettingsUIState();
// }

// class _SettingsUIState extends State<SettingsUI> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "Setting UI",
//       home: EditProfilePage(),
//     );
//   }
// }

// class EditProfilePage extends StatefulWidget {
//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
// List data;
// int id;
// String name
// ,email,pass;
//   List<UserApi> users =[];
// TextEditingController namee = TextEditingController();

//   TextEditingController emaill = TextEditingController();

//   TextEditingController equipe = TextEditingController();
//   TextEditingController password = TextEditingController();

//  String title = "MyTitle";
//   bool isEditable=false;
//   List results;
//     String selected ;

// //int id;
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     this.getJsonData();
//   }


//  getJsonData() async{
//     SharedPreferences prefs = await SharedPreferences.getInstance();
// name =prefs.getString("userName");
// email =prefs.getString("userEmail");
// pass =prefs.getString("userPassword");
// print(name);
//   final String url = "http://192.168.43.203:3000/api/users/updatepassword";

//    // String json = '{"name": "' + names + '", "email": "' + email + '"}';
//     var response = await http.patch(
//       Uri.encodeFull(url),
//       headers : {"Content-type": "application/json"},body: json
//     );
//     String body=response.body;
    
//     Map<String,dynamic> res = jsonDecode(body);
//       print(res);
//     List user = res['results'];
//     setState(() {
// users =user
//  .map((dynamic item) => UserApi.fromJson(item))
//           .toList();
//     });
//     return "Success";
//   }





//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Put your New Paasword'),
//         elevation: 1,
//           leading: IconButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//          },
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.black,
//           ),
//         ),

//       ),
//       body:
//           Container(
//              decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage("Assets/bg.jpg"),
//               fit: BoxFit.cover
//             )
//           ),
//                       child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
              
              
//                Column(
//                               children: [
//                                       Row(
//                     children: [
//         Expanded(
//               child: !isEditable
//                     ? Text(name)
//                     : TextFormField(
//                         initialValue: name,
//                         textInputAction: TextInputAction.done,
//                         onFieldSubmitted: (value) {
//                           setState(() => {isEditable = false, name = value});
//                         })),
    
//       ]),
//       Row(
//                     children: [
//         Expanded(
//               child: !isEditable
//                     ? Text(email)
//                     : TextFormField(
//                         initialValue: email,
//                         textInputAction: TextInputAction.done,
//                         onFieldSubmitted: (value) {
//                           setState(() => {isEditable = false, email = value});
//                         })),
//         IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: () {
//               setState(() => {
//                       isEditable = true,
//                     });
//             },
//         )
//       ]),

//       Row(
//                     children: [
//         Expanded(
//               child: !isEditable
//                     ? Text(pass)
//                     : TextFormField(
//                         initialValue: pass,
//                         textInputAction: TextInputAction.done,
//                                           obscureText: true,

//                        )),
   
//       ]),



      
//     ],
//                ),
//                SizedBox(
//                 height: 10,
//               ),

//               SizedBox(
//                 height: 10,
//               ),
//                     MaterialButton(
//                 color: Colors.purple,
//                 child: Text('Next',style: TextStyle(color: Colors.white),),
//                 onPressed: (){
                 
//                   //login();
//                 },
//               ),
       
//             ],
//         ),
//           ),
//     );
//   }
  

  


//   }
// /*
// int id;
//   List<UserApi> results = [];

//   Future<void>  getResults(String id) async {
//      SharedPreferences prefs = await SharedPreferences.getInstance();
// id=prefs.getString("userID");
//     http.Response response = await http.get(
//         'http://192.168.43.203:3000/api/users/$id',
//         headers: {"Content-type": "application/json"});
//     String body = response.body;
//     var data = jsonDecode(body);
//     List<dynamic> clubList = data['results'];

//     setState(() {
//       results = clubList
//           .map((dynamic item) => UserApi.fromJson(item))
//           .toList();
//     });

//   }


//   @override
//   void initState() {
//     super.initState();
//     getResults(widget.id);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return results.length == 0
//         ? Container(
//       color: Colors.white,
//       child: Center(
//         child: CircularProgressIndicator(
//           valueColor: AlwaysStoppedAnimation<Color>(
//             Color(0xFFe70066),
//           ),
//         ),
//       ),
//     )
//         :Scaffold(
//       appBar: AppBar(
//         title: Text("Broadcast Schedules"),
//         backgroundColor: Colors.blue[300],
//         elevation: 0.0,
//       ),
//       body:
//       ListView.builder(
//         itemBuilder: (context, index){
//           return UserApi(results[index].id,results[index].name,results[index].email, results[index].equipe);
//         },
//         itemCount: results.length,
//       ),

//     );

//   }
// }*/ 