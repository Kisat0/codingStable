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
                                      try {
                                        var collection =
                                            widget.db.collection('courses');
                                        collection.replaceOne({
                                          '_id': snapshot.data?[index]['_id']
                                        }, {
                                          'terrain': snapshot.data?[index]
                                              ['terrain'],
                                          'duration': snapshot.data?[index]
                                              ['duration'],
                                          'speciality': snapshot.data?[index]
                                              ['speciality'],
                                          'isVerified': true,
                                          'date': snapshot.data?[index]['date'],
                                          'idsUsers': snapshot.data?[index]
                                              ['idsUsers'],
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('Demande acceptée')),
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Erreur lors de la validation de la demande')),
                                        );
                                      }
                                    },
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        var collection =
                                            widget.db.collection('courses');
                                        try {
                                          collection.deleteOne({
                                            '_id': snapshot.data?[index]['_id']
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('Demande refusée')),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Erreur lors de la suppression de la demande')),
                                          );
                                        }
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
                                      try {
                                        var collection =
                                            widget.db.collection('parties');
                                        collection.replaceOne({
                                          '_id': snapshot.data?[index]['_id']
                                        }, {
                                          'theme': snapshot.data?[index]
                                              ['theme'],
                                          'picture': snapshot.data?[index]
                                              ['picture'],
                                          'date': snapshot.data?[index]['date'],
                                          'isVerified': true,
                                          'idsUsers': snapshot.data?[index]
                                              ['idsUsers'],
                                          'com': snapshot.data?[index]['com'],
                                        });

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('Demande acceptée')),
                                        );
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Erreur lors de la validation de la demande')),
                                        );
                                      }
                                    },
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        var collection =
                                            widget.db.collection('parties');
                                        try {
                                          collection.deleteOne({
                                            '_id': snapshot.data?[index]['_id']
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content:
                                                    Text('Demande refusée')),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Erreur lors de la suppression de la demande')),
                                          );
                                        }
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
