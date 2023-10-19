import 'package:flutter/material.dart';
import 'package:futter_stable/pageconcours.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(ListeConcours());
}

class Concours {
  final String name;
  final String address;
  final String date;

  Concours({
    required this.name,
    required this.address,
    required this.date,
  });
}

class ListeConcours extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserList(),
    );
  }
}

class UserList extends StatelessWidget {
  final List<Concours> users = [
    Concours(
        name: 'Grand Tour Ecurie', address: '123 Main St', date: '2023-10-18'),
    Concours(name: 'Etalon Tour', address: '456 Elm St', date: '2023-10-19'),
    Concours(name: 'Grand Prix', address: '789 Oak St', date: '2023-10-20'),
    // Add other fictional competitions here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des concours'),
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
                  MaterialPageRoute(builder: (context) => PageConcoursApp()));

              // Handle the submission logic here
              // This function will be called when the submit button is pressed
              // You can access the selected competitions from the 'users' list
            },
            child: Text('Créer un concours'),
          ),

       
        ],
      ),
    );
  }
}
