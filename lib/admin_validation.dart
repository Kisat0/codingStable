import 'package:flutter/material.dart';
import 'package:futter_stable/user_provider.dart';
import 'package:provider/provider.dart';

class AdminValidation extends StatefulWidget {
  final dynamic db;

  const AdminValidation({Key? key, this.db}) : super(key: key);

  @override
  State<AdminValidation> createState() => _AdminValidationState();
}

class _AdminValidationState extends State<AdminValidation> {
  late String role;

  @override
  void initState() {
    super.initState();
    // Assuming you have a way to get the user's role, replace 'getUserRole()' with your actual logic
    role = Provider.of<UserProvider>(context, listen: false).loggedInUser!.role;
  }

  Future<List<dynamic>> getNotValidatedCourses() async {
    var collection = widget.db.collection('courses');
    var result = await collection.find({'isVerified': false}).toList();
    return result;
  }

  Future<List<dynamic>> getNotValidatedParties() async {
    var collection = widget.db.collection('parties');
    var result = await collection.find({'isVerified': false}).toList();
    return result;
  }

  void validateCourse(List<dynamic> course) {
    try {
      var collection = widget.db.collection('courses');
      collection.replaceOne({
        '_id': course[0]['_id']
      }, {
        'terrain': course[0]['terrain'],
        'duration': course[0]['duration'],
        'speciality': course[0]['speciality'],
        'isVerified': true,
        'date': course[0]['date'],
        'idsUsers': course[0]['idsUsers'],
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Demande acceptée')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Erreur lors de la validation de la demande')),
      );
    }
  }

  void validateParty(List<dynamic> party) {
    try {
      var collection = widget.db.collection('parties');
      collection.replaceOne({
        '_id': party[0]['_id']
      }, {
        'theme': party[0]['theme'],
        'picture': party[0]['picture'],
        'date': party[0]['date'],
        'isVerified': true,
        'idsUsers': party[0]['idsUsers'],
        'com': party[0]['com'],
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Demande acceptée')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Erreur lors de la validation de la demande')),
      );
    }
  }

  void deleteCourse(List<dynamic> course) {
    var collection = widget.db.collection('courses');
    try {
      collection.deleteOne({'_id': course[0]['_id']});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Demande refusée')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Erreur lors de la suppression de la demande')),
      );
    }
  }

  void deleteParty(List<dynamic> party) {
    var collection = widget.db.collection('parties');
    collection.deleteOne({'_id': party[0]['_id']});
  }

  @override
  Widget build(BuildContext context) {
    if (role != 'admin') {
      Navigator.pushNamed(context, '/home');
    }
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.newspaper), text: "Cours"),
              Tab(icon: Icon(Icons.newspaper), text: "Soirées"),
            ]),
          ),
          body: TabBarView(
            children: [
              FutureBuilder(
                future: getNotValidatedCourses(),
                builder: (context, snapshot) {
                  if (snapshot.data?.length != null &&
                      snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text(snapshot.data?[index]['terrain']),
                                subtitle:
                                    Text(snapshot.data?[index]['duration']),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    child: const Text('Valider'),
                                    onPressed: () {
                                      validateCourse(snapshot.data?[index]);
                                    },
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        deleteCourse(snapshot.data?[index]);
                                      },
                                      child: const Text('Refuser'))
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Text("Pas de cours à valider");
                  }
                },
              ),
              FutureBuilder(
                future: getNotValidatedParties(),
                builder: (context, snapshot) {
                  if (snapshot.data?.length != null &&
                      snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                title: Text(snapshot.data?[index]['theme']),
                                subtitle: Text(snapshot.data?[index]['date']),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                    child: const Text('Valider'),
                                    onPressed: () {
                                      validateParty(snapshot.data?[index]);
                                    },
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        deleteParty(snapshot.data?[index]);
                                      },
                                      child: const Text('Refuser'))
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Text("Pas de soirées à valider");
                  }
                },
              ),
            ],
          ),
        ));
  }
}
