import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../pages/mongo.dart';

void main() {
  runApp(PageTrainingApp());
}

class PageTrainingApp extends StatelessWidget {
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
  String? dropdownvalue = "Carrière";

  var items = [
    'Carrière',
    'Manège',
  ];


  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Ajoutez ici la logique pour enregistrer le concours
      // Utilisez les valeurs des contrôleurs _nameController, _addressController, et _dateController

      // Par exemple, affichez les données enregistrées dans la consol
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
        _dateController.text =
            '${picked.day}/${picked.month}/${picked.year}'; // Update the date field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programmer un cours'),
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



              DropdownButton(
                value: dropdownvalue,
                icon:
                Icon(Icons.keyboard_arrow_down),
                items: items.map((items))
              )



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
                onPressed: _submitForm,
                child: Text('Enregistrer le concours'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
