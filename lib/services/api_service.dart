import 'dart:convert';

import 'package:news_app_mad/model/article_model.dart';
import 'package:http/http.dart';

class ApiService {
  final endPointUrl =
      "https://newsapi.org/v2/everything?q=bitcoin&apiKey=8ac26d4f16e54857a456b18e75ca17a4";
  Future<List<Article>> getArticle() async {
    Response res = await get(endPointUrl);
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }
}
