import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:juniorhelp/screens/onboarding.dart';
import 'screens/home.dart';
import 'package:juniorhelp/screens/login.dart';
import 'package:juniorhelp/screens/signup.dart';
import 'screens/maps.dart';
import 'screens/statistics.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Junior Help',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          accentColor: Colors.orange,
          fontFamily: 'LibreBaskerville'),
      home: SignUp(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;

  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(currentPage),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(iconData: Icons.home, title: "Home", onclick: () {}),
          TabData(
              iconData: Icons.map,
              title: "Maps",
              onclick: () {
                final FancyBottomNavigationState fState =
                    bottomNavigationKey.currentState;
                fState.setPage(0);
              }),
          TabData(
              iconData: Icons.pie_chart,
              title: "Analytics",
              onclick: () {
                final FancyBottomNavigationState fState =
                    bottomNavigationKey.currentState;
                fState.setPage(1);
              })
        ],
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[Text("Hello"), Text("World")],
        ),
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return Home();
      case 1:
        return Maps();
      case 2:
        return Statistics();
      default:
        return Home();
    }
  }
}
