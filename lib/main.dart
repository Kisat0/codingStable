import 'package:flutter/material.dart';
import 'package:futter_stable/mongo.dart';
import 'package:futter_stable/homepage.dart';
import 'package:futter_stable/login.dart';
import 'package:futter_stable/password_forgot.dart';
import 'package:futter_stable/register.dart';
import 'package:futter_stable/user_provider.dart';
import 'package:futter_stable/reset_password.dart';
import 'package:futter_stable/admin_validation.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  var db = await MongoDataBase.connect();
  runApp(MainApp(db: db));
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key, required this.db}) : super(key: key);

  final dynamic db;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Horse',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => LoginPage(db: db),
          '/home': (context) => HomePage(db: db),
          '/passwordForgot': (context) => ForgotPage(db: db),
          '/resetPassword': (context) => ResetPage(db: db),
          '/adminValidation': (context) => AdminValidation(db: db),
          '/register':(context) => RegisterPage(title: "Inscription",db: db),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
