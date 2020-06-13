import 'package:Firebase_Project_1/src/models/user.dart';
import 'package:Firebase_Project_1/src/screens/authenticate/authenticate.dart';
import 'package:Firebase_Project_1/src/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    if (user == null){
      return Authenticate();
    }
    else{
      return HomePage();
    }
  }
}