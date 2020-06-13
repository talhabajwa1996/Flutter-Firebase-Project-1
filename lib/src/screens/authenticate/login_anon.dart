import '../../services/auth.dart';
import 'package:flutter/material.dart';

class LoginAnonPage extends StatefulWidget {
  @override
  LoginAnonPageState createState() => LoginAnonPageState();
}

class LoginAnonPageState extends State<LoginAnonPage> {
  AuthService _auth = AuthService();

  build(context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              loginWidget(),
              SizedBox(height: 20),
              loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget loginWidget() {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/Icons/login.png'),
            height: 100,
            width: 100,
          ),
          SizedBox(height: 8.0),
          Text(
            'Login Anonymously',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'SourceSansLight',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget loginButton() {
    return RaisedButton(
      child: Text('Login Anonymously'),
      onPressed: () async {
        dynamic result = await _auth.signInAnon();

        if (result == null) {
          print("Error Logging In");
        } else {
          print("Logged In");
          print(result.uid);
        }
      },
    );
  }
}
