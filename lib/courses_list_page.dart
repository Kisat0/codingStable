import 'package:flutter/material.dart';
import 'package:futter_stable/models/course.dart';
import 'package:futter_stable/mongo.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

void main() {
  runApp(CoursesListPage());
}

class CoursesListPage extends StatefulWidget {
  const CoursesListPage({super.key});

  @override
  State<CoursesListPage> createState() => _CoursesListPageState();
}

class _CoursesListPageState extends State<CoursesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: MongoDataBase.getCourses(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    var totalDataLength = snapshot.data.length;
                    print("total data found" + totalDataLength.toString());
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return displayUserCard(
                              CourseModel.fromJson(snapshot.data[index]));
                        });
                  } else {
                    return Center(
                      child: Text("no data available"),
                    );
                  }
                }
              })),
    );
  }

  Widget displayUserCard(CourseModel course) {
    return Card(
      child: Column(
        children: [
          Text("${course.terrain}"),
          SizedBox(
            height: 10,
          ),
          Text("${course.duration}"),
          SizedBox(
            height: 10,
          ),
          Text("${course.speciality}"),
          SizedBox(
            height: 10,
          ),
          Text("${course.date}"),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
