import 'package:flutter/material.dart';
import '../../services/auth.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;

  RegisterPage({this.toggleView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  AuthService _auth = AuthService();

  build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.red[200],
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              setState(() {
                widget.toggleView();
              });
            },
            icon: Icon(Icons.person),
            label: Text('Login'),
          ),
        ],
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                registerWidget(),
                SizedBox(height: 20),
                _email(),
                SizedBox(height: 20),
                _password(),
                SizedBox(height: 20),
                registerButton(),
                SizedBox(height: 20),
                errorText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget registerWidget() {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image(
          //   image: AssetImage('assets/Icons/login.png'),
          //   height: 100,
          //   width: 100,
          // ),
          SizedBox(height: 8.0),
          Text(
            'Register',
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

  Widget _email() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                .hasMatch(value)) {
          return 'Invalid Email';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        return email = value;
      },
    );
  }

  Widget _password() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      obscureText: true,
      onChanged: (value) {
        return password = value;
      },
      validator: (String value) {
        if (value.length < 6) {
          return 'Password must be atleast 6 characters';
        } else {
          return null;
        }
      },
    );
  }

  Widget registerButton() {
    return RaisedButton(
      child: Text('Register'),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          dynamic result =
              await _auth.registerWithEmailAndPassword(email, password);
          if (result == null) {
            setState(() {
              error = 'Please specify a valid Email and Password';
            });
          }
        }
      },
    );
  }

  Widget errorText() {
    return Text(
      error,
      style: TextStyle(
        color: Colors.red,
        fontSize: 14.0,
      ),
    );
  }
}
