import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:futter_stable/models/contest.dart';
import 'package:futter_stable/models/horse.dart';

import 'package:futter_stable/mongo.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

void main() {
  runApp(AddHorse());
}

class AddHorse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  XFile? _selectedImage;
  TextEditingController _coatController = TextEditingController();
  TextEditingController _raceController = TextEditingController();
  TextEditingController _specialityController = TextEditingController();
  TextEditingController _sexeController = TextEditingController();

  Future<void> insertHorse(
    String name,
    String coat,
    String race,
    String speciality,
    String sexe,
  ) async {
    var newHorseId = mongo.ObjectId(); // Generation of a unique id
    final newHorse = Horse(
      id: newHorseId,
      name: name,
      picture: 'picture',
      coat: coat,
      race: race,
      speciality: speciality,
      sexe: sexe,
      rentersId: [],
    );
    var result = await MongoDataBase.insertHorse(newHorse);
    //return result;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("inserted Id" + newHorseId.$oid)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un nouveau cheval'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nom du cheval'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez renseigner le nom du cheval';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _coatController,
                decoration: InputDecoration(labelText: 'Robe du cheval'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez renseigner la robe du cheval';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _raceController,
                decoration: InputDecoration(labelText: 'Race du cheval'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez renseigner la race du cheval';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _specialityController,
                decoration: InputDecoration(labelText: 'Spécialité du cheval'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez renseigner la spécialité du cheval';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sexeController,
                decoration: InputDecoration(labelText: 'Sexe du cheval'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez renseigner le sexe du cheval';
                  }
                  return null;
                },
              ),
              MaterialButton(
                color: Colors.blue,
                child: const Text("Choisissez une image"),
                onPressed: () async {
                  final imagePicker = ImagePicker();
                  final image =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  if (image == null) {
                    setState(() {
                      var imageState = imagePicker;
                    });
                  }
                  ;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    insertHorse(
                        _nameController.text,
                        _coatController.text,
                        _raceController.text,
                        _specialityController.text,
                        _sexeController.text);
                  }
                },
                child: Text('Enregistrer le cheval'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
