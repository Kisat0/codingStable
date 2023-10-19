import 'package:flutter/material.dart';
import 'package:futter_stable/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class ResetPage extends StatefulWidget {
  final dynamic db;

  const ResetPage({Key? key, this.db}) : super(key: key);

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  updateUserPassword(name, mail, password) async {
    var collection = widget.db.collection('users');
    var u = await collection
        .findOne(mongo.where.eq('pseudo', name).eq('email', mail));
    if (u != null) {
      collection.replaceOne(mongo.where.eq('pseudo', name).eq('email', mail), {
        'pseudo': u['pseudo'],
        'email': u['email'],
        'mdp': password,
        'role': u['role'],
        'photo': u['photo'],
        'phone_number': u['phone_number'],
        'age': u['age'],
        'FFE_link': u['FFE_link'],
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Erreur lors de la réinitialisation du mot de passe')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // get the name and the mail from the provider
    final name = Provider.of<UserProvider>(context, listen: false).resetName;
    final mail = Provider.of<UserProvider>(context, listen: false).resetEmail;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Réinitialisation du mot de passe"),
        ),
        body: Center(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Confirm password',
                      ),
                      validator: (value) {
                        if (value != passwordController.text) {
                          return 'Passwords are not the same';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          updateUserPassword(
                              name, mail, passwordController.text);
                          Navigator.pushNamed(context, '/');
                        }
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ))));
  }
}
