import 'package:flutter/material.dart';
import 'package:futter_stable/mongo.dart';
import 'package:futter_stable/homepage.dart';
//import 'package:mongo_dart/mongo_dart.dart';
import 'package:futter_stable/register.dart';


Future<void> main() async {
  var db = await MongoDataBase.connect();
  runApp(MainApp(db: db));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, this.db});


  final dynamic db;
  @override
  Widget build(BuildContext context) {

        return MaterialApp(
      title: 'Horse',
      //debugShowCheckedModeBanner: false,
      //routes: {
      //  '/': (context) => HomePage(db: db),
      //},
          home: const HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white.withAlpha(12000),
      ),
    );

  }
}
