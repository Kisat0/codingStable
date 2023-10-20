import 'package:flutter/material.dart';
import 'package:futter_stable/mongo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;
import 'package:futter_stable/models/party.dart';
void main() {
  runApp(PagePartiesApp());
}

class PagePartiesApp extends StatelessWidget {
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
  TextEditingController _dateController = TextEditingController();
  TextEditingController _typeController = TextEditingController();
  String? dropdownValue = 'Apéro';
  var items = ['Apéro', 'Dîner'];
  DateTime? _selectedDate;
  XFile? _selectedImage;

  Future<void> insertParty(
        dynamic picture,
         DateTime date, 
         String type)
         async {
              var newPartyId = mongo.ObjectId(); // Generation of a unique id

    final newParty = PartyModel(
        picture : 'picture',
        date : date,
        type : type,
        participantsId: []);
    var result = await MongoDataBase.insertParty(newParty);
    //return result;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("inserted Id")));
  }




  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Ajoutez ici la logique pour enregistrer la soirée
      // Utilisez les valeurs des contrôleurs _dateController, dropdownValue, etc.
      // Par exemple, affichez les données enregistrées dans la console
    }
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
        _dateController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }
void dropdownCallback(String ? selectedValue ){
  if(selectedValue is String){
    setState((){
      dropdownValue = selectedValue;
    });
  }
} 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer une nouvelle soirée'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[

              
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.keyboard_arrow_down),
                items: items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: dropdownCallback,
                
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(labelText: 'Date de la soirée'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez renseigner la date de la soirée';
                  }
                  return null;
                },
                onTap: () {
                  _selectDate(context);
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
                      // Gérer le cas où aucune image n'a été sélectionnée
                    });
                  }
                },
              ),
              ElevatedButton(
                onPressed: () {
              if (_formKey.currentState!.validate()) {
                insertParty(_selectedImage, _selectedDate!, _typeController.text);
              }
            },
                child: Text('Enregistrer la soirée'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
