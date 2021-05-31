import 'package:flutter/material.dart';
import 'package:Fantasy/news/artical_model.dart';
import 'package:Fantasy/news/article_view.dart';
import 'package:Fantasy/news/news.dart';


class Homee extends StatefulWidget {

  @override
  _HomeeState createState() => _HomeeState();
}

class _HomeeState extends State<Homee> {
    List<Article> articles = List<Article>();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }
  getNews()async{
    News newsClass =News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     appBar: mainAppBar(),
     

     body:_loading ? Container(
       child : Center(child: CircularProgressIndicator()),
     ) :SingleChildScrollView(
         padding: EdgeInsets.symmetric(horizontal: 16),


      child:  Container(
           padding: EdgeInsets.only(top: 16),

         child : ListView.builder(
           itemCount: articles.length,
           shrinkWrap: true,
           physics: ClampingScrollPhysics(),
           itemBuilder: (context , index){
             return BlogTile(
             imageUrl: articles[index].urlToImage ,
             title : articles[index].title,
             desc: articles[index].description,
             url : articles[index].articleUrl,
             );
           }
           
           )
       )
       
  
       ),
   
    ); 
    
    
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl,title,desc,url;
  BlogTile({@required this.imageUrl,@required this.title,@required this.desc,@required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ArticleView(
            postUrl: url,
          ),
          )
        
        );
      },
          child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child : Column(children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(imageUrl)),
          SizedBox(height: 8,),
          Text(title, style: TextStyle(
            fontSize: 17,
            color: Colors.black87
          ),),
                  SizedBox(height: 8,),

          Text(desc,style: TextStyle(color: Colors.black54),)
        ],
        )
      ),
    );
  }
}
 AppBar mainAppBar() {
    return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "French League ",
          style:
          TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        Text(
          "News",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
        )
      ],
    ),
         backgroundColor: Colors.blue[300],
        elevation: 0.0,
                flexibleSpace: Container(decoration: 
        BoxDecoration(
          gradient: LinearGradient(colors: [Colors.black ,Colors.red],
          begin: Alignment.bottomRight,
          end:Alignment.topLeft)
        ),
        ),
  );
 }


 