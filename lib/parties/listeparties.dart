import 'package:flutter/material.dart';
import 'package:futter_stable/models/party.dart';
import 'package:futter_stable/parties/pageparties.dart';
import 'package:futter_stable/user_model.dart';
import 'package:futter_stable/user_provider.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:provider/provider.dart';

class PartiesListPage extends StatefulWidget {
  const PartiesListPage({Key? key, required this.db}) : super(key: key);
  final dynamic db;
  @override
  State<PartiesListPage> createState() => _PartiesListPageState();
}

class _PartiesListPageState extends State<PartiesListPage> {
  late User? user;

  Future<List<dynamic>> getAllParties() async {
    var collection = widget.db.collection('parties');
    var result = await collection.find().toList();
    return result;
  }

  Future<void> joinParty(dynamic currentUserId, PartyModel party) async {
    var collection = widget.db.collection('parties');
    if (!party.participantsId.contains(currentUserId)) {
      party.participantsId.add(currentUserId);

      await collection.update(
        mongo.where.id(party.id),
        {
          r'$set': {
            'participantsId': party.participantsId,
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
                    builder: (context) => PagePartiesApp(),
                  ),
                );
              },
              child: Text("Créer une nouvelle soirée"),
            ),
            Expanded(
                child: FutureBuilder(
                    future: getAllParties(),
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
                                    PartyModel.fromJson(snapshot.data[index]));
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

  Widget displayUserCard(PartyModel party) {
    bool isConnected = party.participantsId.contains(user?.id);

    if (party.isVerified) {
      return Card(
        color: isConnected ? Colors.green : Colors.white,
        child: Column(
          children: [
            Text("${party.type}"),
            SizedBox(height: 10),
            Text("${party.date}"),
            SizedBox(height: 10),
            Text("${party.picture}"),
            SizedBox(height: 10),
            Text("${party.participantsId}"),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                mongo.ObjectId currentUserId = user?.id;
                joinParty(currentUserId, party);
              },
              child:
                  Text(isConnected ? "Bonne soirée!" : "Rejoindre la soirée"),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
