import 'package:Firebase_Project_1/src/models/user.dart';
import 'package:Firebase_Project_1/src/screens/wrapper/wrapper.dart';
import 'package:Firebase_Project_1/src/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
