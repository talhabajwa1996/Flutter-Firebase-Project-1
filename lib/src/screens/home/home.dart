import 'package:Firebase_Project_1/src/screens/home/brew_list.dart';
import 'package:Firebase_Project_1/src/screens/home/settings.dart';
import 'package:Firebase_Project_1/src/services/auth.dart';
import 'package:Firebase_Project_1/src/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/brew.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  build(context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text('Home Page'),
            backgroundColor: Colors.red[200],
            actions: <Widget>[
              _signOutButtonInAppBar(),
              _showSettingsPanel(),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Background/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BrewList(),
          ),
        ),
      ),
    );
  }

  Widget _signOutButtonInAppBar() {
    return FlatButton.icon(
      onPressed: () async => await _auth.signOut(),
      icon: Icon(Icons.person),
      label: Text('Logout'),
    );
  }

  Widget _showSettingsPanel() {
    return FlatButton.icon(
      icon: Icon(Icons.settings),
      label: Text('Settings'),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            margin: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
            child: SettingsPane(),
          ),
        );
      },
    );
  }
}
