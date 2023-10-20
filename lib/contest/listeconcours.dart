import 'package:flutter/material.dart';
import 'package:futter_stable/contest/pageconcours.dart';
import 'package:futter_stable/coursespage.dart';
import 'package:futter_stable/models/contest.dart';
import 'package:futter_stable/models/course.dart';
import 'package:futter_stable/mongo.dart';
import 'package:futter_stable/pageconcours.dart';
import 'package:futter_stable/user_model.dart';
import 'package:futter_stable/user_provider.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:provider/provider.dart';

class ContestListPage extends StatefulWidget {
  const ContestListPage({Key? key, required this.db}) : super(key: key);
  final dynamic db;
  @override
  State<ContestListPage> createState() => _ContestListPageState();
}

class _ContestListPageState extends State<ContestListPage> {
  late User? user;

  Future<List<dynamic>> getAllContests() async {
    var collection = widget.db.collection('contests');
    var result = await collection.find().toList();
    return result;
  }

  Future<void> joinContest(dynamic currentUserId, ContestModel contest) async {
    var collection = widget.db.collection('contests');
    if (!contest.participantsId.contains(currentUserId)) {
      contest.participantsId.add(currentUserId);

      await collection.update(
        mongo.where.id(contest.id),
        {
          r'$set': {
            'participantsId': contest.participantsId,
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
                    builder: (context) => PageConcoursApp(),
                  ),
                );
              },
              child: Text("Créer un nouveau cours"),
            ),
            Expanded(
                child: FutureBuilder(
                    future: getAllContests(),
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
                                return displayUserCard(ContestModel.fromJson(
                                    snapshot.data[index]));
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

  Widget displayUserCard(ContestModel contest) {
    bool isConnected = contest.participantsId.contains(user?.id);

    if (contest.isVerified) {
      return Card(
        color: isConnected ? Colors.green : Colors.white,
        child: Column(
          children: [
            Text("${contest.name}"),
            SizedBox(height: 10),
            Text("${contest.adress}"),
            SizedBox(height: 10),
            Text("${contest.date}"),
            SizedBox(height: 10),
            Text("${contest.picture}"),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                mongo.ObjectId currentUserId = user?.id;
                joinContest(currentUserId, contest);
              },
              child: Text(isConnected ? "Bon cours!" : "Rejoindre le cours"),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
