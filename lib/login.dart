import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final dynamic db;

  const LoginPage({Key? key, this.db}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState(db: db);
}

class _LoginPageState extends State<LoginPage> {
  final dynamic db;

  _LoginPageState({this.db});
  final _formKey = GlobalKey<FormState>();
  final mailController = TextEditingController();
  final mdpController = TextEditingController();

  login(mail, mdp) async {
    var collection = db.collection('users');
    // hash the mdp to sha256
    var mdpHash = mdp;
    var result = await collection.find({'email': mail, 'mdp': mdpHash}).toList();

    return result;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    mailController.dispose();
    mdpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Connexion"),
      ),
      body: Center(
        child: Form(
          key: _formKey, // Add this line to bind the key
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Connexion"),
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
                controller: mdpController,
                decoration: const InputDecoration(
                  hintText: 'Entrez votre mot de passe',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre mot de passe';
                  }
                  return null;
                },
              ),
              // add a link if the user forgot his password
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/passwordForgot');
                },
                child: const Text(
                  "Mot de passe oublié ?",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var result = await login(mailController.text, mdpController.text);
                    if (result.length > 0) {
                      Navigator.pushNamed(context, '/home');
                        ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Connexion réussie')),
                    );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Erreur de connexion')),
                      );
                    }
                  }
                },
                child: const Text('Connexion'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
