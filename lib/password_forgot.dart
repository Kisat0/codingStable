import 'package:flutter/material.dart';
import 'package:futter_stable/user_provider.dart';
import 'package:provider/provider.dart';

class ForgotPage extends StatefulWidget {
  final dynamic db;

  const ForgotPage({Key? key, this.db}) : super(key: key);

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final _formKey = GlobalKey<FormState>();
  final mailController = TextEditingController();
  final nameController = TextEditingController();

  Future<List<Map<String, dynamic>>> forgot(String mail, String name) async {
    var collection = widget.db.collection('users');
    var result =
        await collection.find({'email': mail, 'pseudo': name}).toList();

    return result.cast<Map<String, dynamic>>();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    mailController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mot de passe oublié"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Mot de passe oublié"),
              TextFormField(
                controller: mailController,
                decoration: const InputDecoration(
                  hintText: 'Entrez votre email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Entrez votre username',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre username';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var result =
                        await forgot(mailController.text, nameController.text);
                    if (result.length > 0) {
                      // add the name and the mail into the provider
                      Provider.of<UserProvider>(context, listen: false)
                          .setResetName(nameController.text);
                      Provider.of<UserProvider>(context, listen: false)
                          .setResetEmail(mailController.text);

                      Navigator.pushNamed(context, '/resetPassword');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Email inconnu'),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Envoyer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
