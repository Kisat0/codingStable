import 'package:flutter/material.dart';
import 'package:futter_stable/models/course.dart';
import 'package:futter_stable/mongo.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

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
  List<String> _CoursesId = [];
  List<String> itemsTerrain = ['Carrière', 'Manège'];
  List<String> itemsSpeciality = ['Dressage', "Saut d'obstable", 'Endurance'];

  Future<void> insertCourse(
      String terrain, String duration, String speciality, DateTime date) async {
    var newCourseId = mongo.ObjectId(); // Generation of a unique id

    final newCourse = CourseModel(
        id: newCourseId,
        terrain: terrain,
        duration: duration,
        speciality: speciality,
        date: date,
        isVerified: false,
        participantsId: []);
    var result = await MongoDataBase.insertCourse(newCourse);
    //return result;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("inserted Id")));
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
    final DateTime currentDate = DateTime.now();
    final DateTime pickedDate = (await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: DateTime(2101),
    ))!;

    if (pickedDate != null) {
      final TimeOfDay currentTime = TimeOfDay.now();
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: currentTime,
      );

      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          _selectedDate = pickedDateTime;
          _dateController.text =
              '${pickedDate.day}/${pickedDate.month}/${pickedDate.year} ${pickedTime.format(context)}';
        });
      }
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
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                insertCourse(_terrain, _duration, _speciality, _selectedDate!);
              }
            },
            child: Text('Soumettre'),
          ),
        ],
      ),
    );
  }
}
