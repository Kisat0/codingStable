import 'package:flutter/material.dart';
import 'package:futter_stable/user_model.dart';
import 'package:futter_stable/user_provider.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.db}) : super(key: key);

  final dynamic db;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User? user;

  final _formKey = GlobalKey<FormState>();

  late TextEditingController pseudoController;
  late TextEditingController mailController;
  late TextEditingController mdpController;
  late TextEditingController phoneController;
  late TextEditingController ageController;
  late TextEditingController ffeController;
  late TextEditingController photoController;

  Future<List<dynamic>> getAllAvailableHorses() async {
    var collection = widget.db.collection('horses');
    var result = await collection.find().toList();
    return result;
  }

  @override
  void initState() {
    super.initState();

    user = Provider.of<UserProvider>(context, listen: false).loggedInUser;
    pseudoController = TextEditingController(text: user?.pseudo);
    mailController = TextEditingController(text: user?.email);
    mdpController = TextEditingController(text: user?.mdp);
    phoneController = TextEditingController(text: user?.phone_number);
    ageController = TextEditingController(text: user?.age);
    ffeController = TextEditingController(text: user?.FFE_link);
    photoController = TextEditingController(text: user?.photo);
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Profil"),
    ),
    body: Center(
      child: Row(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 200,
                    height: 200,
                    child: Image.network(
                      photoController.text ??
                          "https://i.pinimg.com/originals/57/51/ab/5751ab5082e364477876a999b688a8b5.jpg",
                    ),
                  ),
                  TextFormField(
                    controller: pseudoController,
                    decoration: const InputDecoration(
                      hintText: 'Pseudo',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre pseudo';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: mailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
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
                      hintText: 'Mot de passe',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre mot de passe';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      hintText: 'Numéro de téléphone',
                    ),
                  ),
                  TextFormField(
                    controller: ageController,
                    decoration: const InputDecoration(
                      hintText: 'Age',
                    ),
                  ),
                  TextFormField(
                    controller: ffeController,
                    decoration: const InputDecoration(
                      hintText: 'Lien FFE',
                    ),
                  ),
                  TextFormField(
                    controller: photoController,
                    decoration: const InputDecoration(
                      hintText: 'Lien de la photo',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var result = await widget.db.collection("users").replaceOne(
                          {
                            '_id': user?.id
                          },
                          {
                            'pseudo': pseudoController.text,
                            'email': mailController.text,
                            'mdp': mdpController.text,
                            'role': user?.role,
                            'photo': photoController.text,
                            'phone_number': phoneController.text,
                            'age': ageController.text,
                            'FFE_link': ffeController.text,
                          },
                        );
                        if (result != null) {
                          setState(() {   });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Profil mis à jour'),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Erreur lors de la mise à jour'),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text('Mettre à jour'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
       child: FutureBuilder(
  future: getAllAvailableHorses(),
  builder: (context, snapshot) {
    if (snapshot.data?.length != null && snapshot.data!.isNotEmpty) {
      return ListView.builder(
        itemCount: snapshot.data?.length,
        itemBuilder: (context, index) {
          bool isOwnerNull = snapshot.data?[index]['idOwner'] == null;

          return Card(
            color: isOwnerNull ? Colors.red : null, 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(
                    snapshot.data?[index]["photo"] ??
                        "https://i.pinimg.com/originals/57/51/ab/5751ab5082e364477876a999b688a8b5.jpg",
                  ),
                ),
                ListTile(
                  title: Text(snapshot.data?[index]['name']),
                  subtitle: Text(snapshot.data?[index]['race']),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    if (!isOwnerNull) // Show button only if idOwner is null
                      TextButton(
                        child: const Text('Adopter'),
                        onPressed: () {
                          try {
                            var collection = widget.db.collection('horses');
                            collection.replaceOne(
                              {
                                '_id': snapshot.data?[index]['_id']
                              },
                              {
                                'name': snapshot.data?[index]['name'],
                                'photo': snapshot.data?[index]['photo'],
                                'coat': snapshot.data?[index]['coat'],
                                'race': snapshot.data?[index]['race'],
                                'specialities': snapshot.data?[index]['specialities'],
                                'sexe': snapshot.data?[index]['sexe'],
                                'idOwner': user?.id,
                              },
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Cheval adopté ! :D ')),
                            );
                            setState(() {});
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Erreur lors de la validation de la demande')),
                            );
                          }
                        },
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    } else {
      return const Text("Pas de chevaux disponibles");
    }
  },
),

          ),
        ],
      ),
    ),
  );
}

}
