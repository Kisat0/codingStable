import 'dart:io';

import 'package:flutter/material.dart';
import 'package:futter_stable/parties/pageparties.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(ListeParties());
}

class Parties {
  final String name;
  final String address;
  final String date;
  final File photo;

  Parties({
    required this.name,
    required this.address,
    required this.date,
    required this.photo,
  });
}

class ListeParties extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserList(),
    );
  }
}

class UserList extends StatelessWidget {
  final List<Parties> users = [
    Parties(
        name: 'Grand Tour Ecurie',
        address: '123 Main St',
        date: '2023-10-18',
        photo: File("path")),
    Parties(
        name: 'Etalon Tour',
        address: '456 Elm St',
        date: '2023-10-19',
        photo: File("path")),
    Parties(
        name: 'Grand Prix',
        address: '789 Oak St',
        date: '2023-10-20',
        photo: File("path")),
    // Add other fictional competitions here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des soirées'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.address),
                  trailing: Text(user.date),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PagePartiesApp()));

              // Handle the submission logic here
              // This function will be called when the submit button is pressed
              // You can access the selected competitions from the 'users' list
            },
            child: Text('Créer une soirée'),
          ),
        ],
      ),
    );
  }
}
