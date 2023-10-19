import 'package:flutter/material.dart';
import 'package:futter_stable/admin_validation.dart';
import 'package:futter_stable/coursespage.dart';
import 'package:futter_stable/profile.dart';
import 'package:futter_stable/register.dart';

class HomePage extends StatefulWidget {
  final dynamic db;

  const HomePage({Key? key, this.db}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.lightBlue[800],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Accueil'),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person),
            label: 'Inscription',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.dashboard),
            icon: Icon(Icons.dashboard),
            label: 'Connexion',
          ),
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Flux d\'actualité'),
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Profil'),
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Mes cours'),
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Concours'),
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Soirée'),
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Entraînement'),
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Admin'),
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Test'),
        ],
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const Text('Page 1'),
        ),
        Container(
          alignment: Alignment.center,
          child: RegisterPage(
            title: 'toto',
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 4'),
        ),
        Container(
          alignment: Alignment.center,
          child:  ProfilePage(db: widget.db),
        ),
        Container(
          alignment: Alignment.center,
          child: CoursesPage(),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 7'),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 8'),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 9'),
        ),
        Container(
          alignment: Alignment.center,
          child: AdminValidation(db: widget.db),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 11'),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('Page 12'),
        ),
      ][currentPageIndex],
    );
  }
}
