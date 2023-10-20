import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:futter_stable/mongo.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'constants.dart';

import 'models/UserModel.dart';
import 'models/contest.dart';
import 'models/course.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  Widget createContestsListView(BuildContext context, AsyncSnapshot snapshot) {
    var values = snapshot.data;
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return values.isNotEmpty
            ? Column(
          children: <Widget>[
            ListTile(
              title: Text(
                  Contest.fromJson(values[index]).name),
              subtitle: Row(
                children: [
                  Text(Contest.fromJson(values[index]).level + " - "),
                  Text(Contest.fromJson(values[index]).adress + " min - "),
                  Text(Contest.fromJson(values[index]).date.toString()),
                ],
              ),

              isThreeLine: true,
            ),
            Divider(
              height: 2.0,
            ),
          ],
        )
            : CircularProgressIndicator();
      },
    );
  }

  Widget createCoursesListView(BuildContext context, AsyncSnapshot snapshot) {
    var values = snapshot.data;
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return values.isNotEmpty
            ? Column(
          children: <Widget>[
            ListTile(
              title: Text(
                  CourseModel.fromJson(values[index]).speciality),
              subtitle: Row(
                children: [
                  Text(CourseModel.fromJson(values[index]).terrain + " - "),
                  Text(CourseModel.fromJson(values[index]).duration + " min - "),
                  Text(CourseModel.fromJson(values[index]).date.toString()),
                ],
              ),

              isThreeLine: true,

            ),
            Divider(
              height: 2.0,
            ),
          ],
        )
            : CircularProgressIndicator();
      },
    );
  }


  String selectedCountry = "AF";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        SizedBox(height: 50),
        const Text("FLUX D'ACTUALITEES "),
        SizedBox(height: 50),
        const Text("ENTRAINEMENTS DISPONIBLES"),
        Expanded(
          child: FutureBuilder(
              future: MongoDataBase.getCourses(),
              initialData: [],
              builder: (context, snapshot) {
                return createCoursesListView(context, snapshot);
              }),
        ),
        SizedBox(height: 50),
        const Text("CONCOURS DISPONIBLES"),
        Expanded(
          child: FutureBuilder(
              future: MongoDataBase.getContest(),
              initialData: [],
              builder: (context, snapshot) {
                return createContestsListView(context, snapshot);
              }),
        ),
        SizedBox(height: 50),
        const Text("CONCOURS DISPONIBLES"),
        Expanded(
          child: FutureBuilder(
              future: MongoDataBase.getContest(),
              initialData: [],
              builder: (context, snapshot) {
                return createContestsListView(context, snapshot);
              }),
        ),
      ]),
    );
  }
}