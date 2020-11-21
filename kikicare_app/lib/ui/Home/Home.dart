import 'package:flutter/material.dart';
import 'package:kikicare_app/util/constants.dart';
import 'package:provider/provider.dart';
import 'package:kikicare_app/model/User.dart';
import 'Adoption.dart';
import 'LostAndFound/LostAndFound.dart';
import 'MyAnimals.dart';
import 'package:kikicare_app/model/Animal.dart';

import 'package:flutter/services.dart';

import 'Profile.dart';


class HomeScreen extends StatefulWidget
{
  final User _user;
  HomeScreen(this._user);
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'KiKicare',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: ChangeNotifierProvider<BottomNavigationBarProvider>(
        child: BottomNavigationBarExample(),
        builder: (BuildContext context) => BottomNavigationBarProvider(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}


class BottomNavigationBarExample extends StatefulWidget
{
  @override
  _BottomNavigationBarExampleState createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample>
{
  var currentTab = [
    AnimalList(),
    Adoption(),
    LostAndFound(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context)
  {
    var provider = Provider.of<BottomNavigationBarProvider>(context);
    return Scaffold(
      body: currentTab[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.currentIndex = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.pets),
            label: "My Animals",
            backgroundColor: Colors.deepOrangeAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.clean_hands_outlined),
            label: "Adoption",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.saved_search),
            label: "Lost & Found",
          ),
            BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            label: "Profile",
          )
        ],
      ),
    );
  }
}


class BottomNavigationBarProvider with ChangeNotifier
{
  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  set currentIndex(int index)
  {
    _currentIndex = index;
    notifyListeners();
  }
}



