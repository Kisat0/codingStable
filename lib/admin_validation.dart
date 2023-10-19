import 'package:flutter/material.dart';
import 'package:futter_stable/user_provider.dart';
import 'package:provider/provider.dart';

class AdminValidation extends StatefulWidget {
  final dynamic db;

  const AdminValidation({Key? key, this.db}) : super(key: key);

  @override
  State<AdminValidation> createState() => _AdminValidationState();
}

class _AdminValidationState extends State<AdminValidation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Validation des utilisateurs"),
        ),
        body: Center(
            child: Column(children: [
              // print the user from the provider
          Text(Provider.of<UserProvider>(context, listen: false).loggedInUser?.UserToString() ?? '', 
            style: TextStyle(color: Colors.black)),
        ])));
  }
}
