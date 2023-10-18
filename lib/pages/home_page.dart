import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  // Const homepage with title and db
  MyHomePage({super.key, this.db});

  final db;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // supprimer le const après pour mettre des valeurs dynamiques
      body: Center(
        child: Column(
          children: [Text("Hello, je suis la home page")],
        ),
      ),
    );
  }
}
