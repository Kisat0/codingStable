import 'package:flutter/material.dart';
import 'package:futter_stable/add_horse/add_horse.dart';
import 'package:futter_stable/admin_validation.dart';
import 'package:futter_stable/contest/listeconcours.dart';
import 'package:futter_stable/contest/pageconcours.dart';
import 'package:futter_stable/courses_list_page.dart';
import 'package:futter_stable/coursespage.dart';
import 'package:futter_stable/feed.dart';
import 'package:futter_stable/pageconcours.dart';
import 'package:futter_stable/parties/listeparties.dart';
import 'package:futter_stable/parties/pageparties.dart';
import 'package:futter_stable/profile.dart';
import 'package:futter_stable/register.dart';
import 'package:futter_stable/user_provider.dart';
import 'package:provider/provider.dart';

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
            if (index == 8) {
              Provider.of<UserProvider>(context, listen: false).logoutUser();
              Navigator.pushNamed(context, '/');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Déconnexion réussie')),
              );
            } else {
              currentPageIndex = index;
            }
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
              label: 'X'),
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Admin'),
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Logout'),
        ],
      ),
      body: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const Text('Page 1'),
        ),
        Container(
          alignment: Alignment.center,
          child: FeedPage(),
        ),
        Container(
          alignment: Alignment.center,
          child: ProfilePage(db: widget.db),
        ),
        Container(
          alignment: Alignment.center,
          child: CoursesListPage(db: widget.db),
        ),
        Container(
          alignment: Alignment.center,
          child: ContestListPage(db: widget.db),
        ),
        Container(
          alignment: Alignment.center,
          child: PartiesListPage(db: widget.db),
        ),
        Container(
          alignment: Alignment.center,
          child: AddHorse(),
        ),
        Container(
          alignment: Alignment.center,
          child: AdminValidation(db: widget.db),
        ),
      ][currentPageIndex],
    );
  }
}
