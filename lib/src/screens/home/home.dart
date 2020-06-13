import 'package:Firebase_Project_1/src/services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final AuthService _auth = AuthService();

  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Home Page'),
          backgroundColor: Colors.red[200],
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async => await _auth.signOut(),
              icon: Icon(Icons.person),
              label: Text('Logout'),
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(8.0),
          child: Text('Some Text Here'),
        ),
      ),
    );
  }
}
