import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:futter_stable/pages/mongo.dart';
//import 'package:mongo_dart/mongo_dart.dart';


import 'pages/home_page.dart';

Future<void> main() async {
  var db = await MongoDataBase.connect();
  runApp(MainApp(db: db));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, this.db});


  final db;
  @override
  Widget build(BuildContext context) {

        return MaterialApp(
      title: 'Horse',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => MyHomePage(db: db),
      },
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white.withAlpha(12000),
      ),
    );

  }
}
