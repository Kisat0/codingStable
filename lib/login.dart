import 'package:flutter/material.dart';
import 'package:futter_stable/user_model.dart';
import 'package:futter_stable/user_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final dynamic db;

  const LoginPage({Key? key, required this.db}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState(db: db);
}

class _LoginPageState extends State<LoginPage> {
  final dynamic db;

  _LoginPageState({required this.db});

  final _formKey = GlobalKey<FormState>();
  final mailController = TextEditingController();
  final mdpController = TextEditingController();

  Future<User?> login(String mail, String mdp) async {
    var collection = db.collection('users');
    // hash the mdp to sha256
    var mdpHash = mdp;
    var result = await collection.find({'email': mail, 'mdp': mdpHash}).toList();

    result = result[0];

    final user = User(
      result["_id"],
      result["pseudo"],
      result["email"],
      result["mdp"],
      result["role"],
      result["photo"],
      result["phone_number"],
      result["age"],
      result["FFE_link"],
    );

    return user;
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
        title: const Text("Connexion"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Connexion"),
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
                    var user = await login(mailController.text, mdpController.text);
                    if (user != null) {
                      Provider.of<UserProvider>(context, listen: false).loginUser(user);
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
