import 'package:flutter/material.dart';
import 'package:futter_stable/user_model.dart';
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

    Future.delayed(Duration.zero, () {
      if (role != 'admin') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Vous n\'êtes pas autorisé à accéder à cette page')),
        );
        Navigator.pushNamed(context, '/home');
      }
    });
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

  Future<List<dynamic>> getUsers() async {
    var collection = widget.db.collection('users');
    var result = await collection.find({'role': {'\$ne': 'admin'}}).toList();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.newspaper), text: "Cours"),
              Tab(icon: Icon(Icons.newspaper), text: "Soirées"),
              Tab(icon: Icon(Icons.newspaper), text: "Utilisateurs"),
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
                                          'participantsId': snapshot.data?[index]
                                              ['participantsId'],
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text('Demande acceptée')),
                                        );
                                        setState(() {});
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
                                          setState(() {});
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
                        return Card(
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
                                          'participantsId': snapshot.data?[index]
                                              ['participantsId'],
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
                                          setState(() {});
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
              FutureBuilder(
                future: getUsers(),
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
                                title: Text(snapshot.data?[index]["pseudo"]),
                                subtitle: Text(snapshot.data?[index]["email"]),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  TextButton(
                                      onPressed: () async {
                                        var collection =
                                            widget.db.collection('users');
                                        var collectionHorses =
                                            widget.db.collection('horses');
                                        var collectionCourses =
                                            widget.db.collection('courses');
                                        var collectionParties =
                                            widget.db.collection('parties');
                                        try {
                                          await collection.deleteOne({
                                            '_id': snapshot.data?[index]['_id']
                                          });
                                          await collectionHorses.deleteMany({
                                            'idOwner': snapshot.data?[index]
                                                ['_id']
                                          });
                                          await collectionCourses.deleteMany({
                                            'participantsId': snapshot.data?[index]
                                                ['_id']
                                          });
                                          await collectionParties.deleteMany({
                                            'participantsId': snapshot.data?[index]
                                                ['_id']
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Utilisateur supprimé')),
                                          );
                                          setState(() {});
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    'Erreur lors de la suppression de l\'utilisateur')),
                                          );
                                        }
                                      },
                                      child: const Text('Supprimer'),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.red),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white)))
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Text("Pas d'utilisateurs");
                  }
                },
              ),
            ],
          ),
        ));
  }
}
