import 'package:flutter/material.dart';
import 'package:futter_stable/mongo.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

import 'models/UserModel.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title, required this.db});

  final String title;
  final dynamic db;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

//STATE DEBUT ICI ---------------------------------------------------------------
class _RegisterPageState extends State<RegisterPage> {
  int _counter = 0;
  var insertNameController = new TextEditingController();
  var insertEmailController = new TextEditingController();
  var insertPasswordController = new TextEditingController();

  Future<void> insertUser(String name, String email, String mdp) async {
    var newUserId = mongo.ObjectId(); // Generation of a unique id
    final newUser = UserModel(
        id: newUserId,
        pseudo: 'toto',
        email: 'toto@gmail.com',
        mdp: '123',
        role: 'user',
        userId: null);
    var result = await MongoDataBase.insertUser(newUser);
    //return result;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("inserted Id" + newUserId.$oid)));
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

//remove dependency id , add other constant , make collection inside mongo private
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('JACQUE CHIRAC :'),
              Text("insert data"),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: insertNameController,
                decoration: InputDecoration(labelText: "name"),
              ),
              TextField(
                controller: insertEmailController,
                decoration: InputDecoration(labelText: "email"),
              ),
              TextField(
                controller: insertPasswordController,
                decoration: InputDecoration(labelText: "mot de passe"),
              ),
               GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                child: const Text(
                  "Déjà un compte ? Connectez-vous ici !",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              Row(
                children: [
                  OutlinedButton(
                      onPressed: () {
                        insertUser("toto", "email", "mdp");
                      },
                      child: Text("validate"))
                ],
              )
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
