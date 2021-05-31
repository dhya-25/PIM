import 'package:Fantasy/news/artical_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class News {

  List<Article> news  = [];

  Future<void> getNews() async{

    String url = "https://newsapi.org/v2/top-headlines?country=fr&category=sports&apiKey=228b869595d14279b570b52115d9ac3b";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }
  }
}

class NewsForCategorie {

  List<Article> news  = [];

  Future<void> getNewsForCategory(String category) async{

    /*String url = "http://newsapi.org/v2/everything?q=$category&apiKey=${apiKey}";*/
    String url = "http://newsapi.org/v2/top-headlines?country=fr&category=business&apiKey=228b869595d14279b570b52115d9ac3b";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData['status'] == "ok"){
      jsonData["articles"].forEach((element){

        if(element['urlToImage'] != null && element['description'] != null){
          Article article = Article(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            urlToImage: element['urlToImage'],
            content: element["content"],
            articleUrl: element["url"],
          );
          news.add(article);
        }

      });
    }


  }
}