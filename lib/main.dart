// @dart=2.9

import 'package:news_app_mad/helper/data.dart';
import 'package:news_app_mad/model/category_model.dart';
import 'package:news_app_mad/services/api_service.dart';
import 'package:flutter/material.dart';
import 'components/custom_list_tile.dart';
import 'model/article_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<CategoryModel> categories = <CategoryModel>[];
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   categories = getCategories() as List<CategoryModel>;
  // }
  //Fetching Data from API
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text("Flutter", style: TextStyle(
                color: Colors.black
              ),),
              Text("News", style: TextStyle(
                color: Colors.blue
              ),)
            ]
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),

        body: FutureBuilder(
          future: client.getArticle(),
          builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasData) {
              List<Article> articles = snapshot.data;
              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) =>
                    customListTile(articles[index], context),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  // const CategoryTile({Key? key}) : super(key: key);
  final imageUrl, categoryName;

  const CategoryTile({Key key, this.imageUrl, this.categoryName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Image.network(imageUrl, width: 120, height: 60,),
        ],
      )
    );
  }
}
