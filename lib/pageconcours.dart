// import 'package:flutter/material.dart';

// void main() {
//   runApp(PageConcours());
// }

// class PageConcours extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Formulaire Flutter de Base'),
//         ),
//         body: MyForm(),
//       ),
//     );
//   }
// }

// class MyForm extends StatefulWidget {
//   @override
//   _MyFormState createState() => _MyFormState();
// }

// class _MyFormState extends State<MyForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String _name = '';
//   String _email = '';

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       print('Nom: $_name');
//       print('Email: $_email');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: <Widget>[
//           TextFormField(
//             decoration: InputDecoration(labelText: 'Nom'),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Veuillez entrer un nom';
//               }
//               return null;
//             },
//             onSaved: (value) {
//               _name = value!;
//             },
//           ),
//           TextFormField(
//             decoration: InputDecoration(labelText: 'Email'),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Veuillez entrer une adresse e-mail';
//               }
//               if (!value.contains('@')) {
//                 return 'Adresse e-mail invalide';
//               }
//               return null;
//             },
//             onSaved: (value) {
//               _email = value!;
//             },
//           ),
//           ElevatedButton(
//             onPressed: _submitForm,
//             child: Text('Soumettre'),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'pages/mongo.dart';
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
                      if(image == null) {
                        setState((){
                          var imageState = imagePicker;
                        });
                      };

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
