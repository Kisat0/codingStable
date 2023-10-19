import 'package:flutter/material.dart';

void main() {
  runApp(CoursesPage());
}

class CoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Formulaire Flutter de Base'),
        ),
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  String _terrain = 'Carrière';
  String _duration = '';
  String _speciality = 'Dressage';
  DateTime? _selectedDate;
  List<String> _usersId = [];
  List<String> itemsTerrain = ['Carrière', 'Manège'];
  List<String> itemsSpeciality = ['Dressage', "Saut d'obstable", 'Endurance'];
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  void dropdownCallbackTerrain(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _terrain = selectedValue;
      });
    }
  }

  void dropdownCallbackSpeciality(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _speciality = selectedValue;
      });
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
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          DropdownButton<String>(
            value: _terrain,
            items: itemsTerrain.map((item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            onChanged: dropdownCallbackTerrain,
          ),
          TextFormField(
            controller: _durationController,
            decoration: InputDecoration(labelText: 'Durée du cours'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Veuillez renseigner la durée du cours en minutes';
              }

              int duration;
              try {
                duration = int.parse(value);
              } catch (e) {
                return 'Veuillez entrer un nombre valide.';
              }

              if (duration < 30 || duration > 60) {
                return 'La durée doit être entre 30 et 60 minutes.';
              }

              return null;
            },
            onChanged: (value) {
              _duration = value;
            },
          ),
          DropdownButton<String>(
            value: _speciality,
            items: itemsSpeciality.map((item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            onChanged: dropdownCallbackSpeciality,
          ),
          TextFormField(
            controller: _dateController,
            decoration: InputDecoration(labelText: 'Date du cours'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Veuillez renseigner la date du cours';
              }
              return null;
            },
            onTap: () {
              _selectDate(context);
            },
          ),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Soumettre'),
          ),
        ],
      ),
    );
  }
}
