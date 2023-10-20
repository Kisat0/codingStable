import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:futter_stable/models/contest.dart';
import 'package:futter_stable/mongo.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

void main() {
  runApp(PageConcoursApp());
}

class PageConcoursApp extends StatelessWidget {
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
  TextEditingController _addressController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;
  XFile? _selectedImage;

  Future<void> insertContest(
    String name,
    String adress,
    DateTime date,
  ) async {
    var newContestId = mongo.ObjectId(); // Generation of a unique id
    final newContest = ContestModel(
      id: newContestId,
      name: name,
      picture: 'picture',
      adress: adress,
      date: date,
      level: '',
      isVerified: false,
      participantsId: [],
    );
    var result = await MongoDataBase.insertContest(newContest);
    //return result;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("inserted Id" + newContestId.$oid)));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text =
            '${picked.day}/${picked.month}/${picked.year}'; // Update the date field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un nouveau concours'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nom du concours'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez renseigner le nom du concours';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Adresse du concours'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez renseigner l\'adresse du concours';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date du concours'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez renseigner la date du concours';
                  }
                  return null;
                },
                onTap: () {
                  _selectDate(context); // Show the date picker
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
                    insertContest(_nameController.text, _addressController.text,
                        _selectedDate!);
                  }
                },
                child: Text('Enregistrer le concours'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
