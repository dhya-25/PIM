import 'package:flutter/material.dart';
import 'package:Fantasy/Tables/TableSceen.dart';
import 'package:Fantasy/news%20copy/standings.dart';
import 'package:Fantasy/news%20copy/totalFixtures.dart';
import 'package:Fantasy/news%20copy/upcomingMatches.dart';
import 'package:Fantasy/news/home.dart';
import 'package:Fantasy/news/homee.dart';
import 'package:Fantasy/widgets/Last_Listtt.dart';
import 'package:Fantasy/widgets/Last_list.dart';



   String leagueCode,id;
   
 Color  leagueColor;
class latestt extends StatefulWidget {
  
  const latestt({Key key}) : super(key: key);

  @override
  _latesttState createState() => _latesttState();
}

class _latesttState extends State<latestt> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Latest"),
                backgroundColor: Colors.blue[300],
        elevation: 0.0,
                flexibleSpace: Container(decoration: 
        BoxDecoration(
          gradient: LinearGradient(colors: [Colors.black ,Colors.red],
          begin: Alignment.bottomRight,
          end:Alignment.topLeft)
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
                  child: SingleChildScrollView(
            child :Column(
            children:  [
              
              NewsCopy,
              ListTile(
  title: Text("All News"),
  leading: CircleAvatar(backgroundColor: Colors.blue,),
  trailing: Icon(Icons.next_plan),
    onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>Homee(),),);

},
),
              tableList,
              ListTile(
  
),
              Results,
              ListTile(
  title: Text("All Results"),
  leading: CircleAvatar(backgroundColor: Colors.blue,),
  trailing: Icon(Icons.next_plan),
    onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>LastMatches(id),),);

},
),
              Fixturess,
             ListTile(
  title: Text("All Fixtures"),
  leading: CircleAvatar(backgroundColor: Colors.blue,),
  trailing: Icon(Icons.next_plan),
  
    onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>TotalFixtures(leagueCode,leagueColor),),);

},
),
              ],
              )



          ),
        ),
      ));
  }
}



Widget NewsCopy = Container(
height :400,

// width: double.infinity,
// padding: EdgeInsets.only(top: 16),
decoration: BoxDecoration(
  color: Colors.grey,
 borderRadius: BorderRadius.circular(20)
),
child :Home()
);

Widget tableList =Container(
height :400,
// width: double.infinity,
// margin: EdgeInsets.all(20),
//           padding: EdgeInsets.only(top: 16),
decoration: BoxDecoration(
  color: Colors.grey,
  borderRadius: BorderRadius.circular(20)
),

child : TableScreen()


    );



Widget Results = Container(
height :400,

// margin: EdgeInsets.all(20),
//   padding: EdgeInsets.only(top: 16),
decoration: BoxDecoration(
  color: Colors.grey,
  borderRadius: BorderRadius.circular(20)
),
child :LastMatch(id)
);


Widget Fixturess = Container(

height :400,
//margin: EdgeInsets.all(20),
 //padding: EdgeInsets.only(top: 16),
decoration: BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(20)
),
child :upcomingMatches(leagueCode,leagueColor)
);



 