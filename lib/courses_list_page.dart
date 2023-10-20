import 'package:flutter/material.dart';
import 'package:futter_stable/coursespage.dart';
import 'package:futter_stable/models/course.dart';
import 'package:futter_stable/mongo.dart';
import 'package:futter_stable/user_model.dart';
import 'package:futter_stable/user_provider.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:provider/provider.dart';

class CoursesListPage extends StatefulWidget {
  const CoursesListPage({Key? key, required this.db}) : super(key: key);
  final dynamic db;
  @override
  State<CoursesListPage> createState() => _CoursesListPageState();
}

class _CoursesListPageState extends State<CoursesListPage> {
  late User? user;

  Future<List<dynamic>> getAllCourses() async {
    var collection = widget.db.collection('courses');
    var result = await collection.find().toList();
    return result;
  }

  Future<void> joinCourse(dynamic currentUserId, CourseModel course) async {
    var collection = widget.db.collection('courses');
    if (!course.participantsId.contains(currentUserId)) {
      course.participantsId.add(currentUserId);

      await collection.update(
        mongo.where.id(course.id),
        {
          r'$set': {
            'participantsId': course.participantsId,
          },
        },
      );
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("inserted Id")));
  }

  @override
  void initState() {
    super.initState();

    user = Provider.of<UserProvider>(context, listen: false).loggedInUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CoursesPage(),
                  ),
                );
              },
              child: Text("Créer un nouveau cours"),
            ),
            Expanded(
                child: FutureBuilder(
                    future: getAllCourses(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.hasData) {
                          var totalDataLength = snapshot.data.length;
                          print(
                              "total data found" + totalDataLength.toString());
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
          ],
        ),
      ),
    );
  }

  Widget displayUserCard(CourseModel course) {
    bool isConnected = course.participantsId.contains(user?.id);

    return Card(
      color: isConnected ? Colors.green : Colors.white,
      child: Column(
        children: [
          Text("${course.terrain}"),
          SizedBox(height: 10),
          Text("${course.duration}"),
          SizedBox(height: 10),
          Text("${course.speciality}"),
          SizedBox(height: 10),
          Text("${course.date}"),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              mongo.ObjectId currentUserId = user?.id;
              joinCourse(currentUserId, course);
            },
            child: Text(isConnected ? "Bon cours!" : "Rejoindre le cours"),
          ),
        ],
      ),
    );
  }
}
