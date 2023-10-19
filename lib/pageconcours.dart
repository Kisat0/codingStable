import 'package:flutter/material.dart';

void main() {
  runApp(PageConcours());
}

class PageConcours extends StatelessWidget {
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
  String _name = '';
  String _email = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Nom: $_name');
      print('Email: $_email');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 'Nom'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Veuillez entrer un nom';
              }
              return null;
            },
            onSaved: (value) {
              _name = value!;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Veuillez entrer une adresse e-mail';
              }
              if (!value.contains('@')) {
                return 'Adresse e-mail invalide';
              }
              return null;
            },
            onSaved: (value) {
              _email = value!;
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
