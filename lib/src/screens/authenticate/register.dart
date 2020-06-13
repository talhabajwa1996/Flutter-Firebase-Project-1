import 'package:flutter/material.dart';
import '../../services/auth.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;

  RegisterPage({this.toggleView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _formKey = GlobalKey<FormState>();

  AuthService _auth = AuthService();

  bool _loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override

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
                _registerWidget(),
                SizedBox(height: 20),
                _email(),
                SizedBox(height: 20),
                _password(),
                SizedBox(height: 20),
                _registerButton(),
                SizedBox(height: 20),
                _loadingCircle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _registerWidget() {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
      decoration: inputFieldsDecoration.copyWith(hintText: 'Email'),
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
      decoration: inputFieldsDecoration.copyWith(hintText: 'Password'),
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

  Widget _registerButton() {
    return RaisedButton(
      child: Text('Register'),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          setState(() => _loading = true);
          dynamic result =
              await _auth.registerWithEmailAndPassword(email, password);
          if (result == null) {
            setState(() {
              _loading = false;
              error = 'Please specify a valid Email and Password';
            });
          }
        }
      },
    );
  }

  Widget _loadingCircle() {
    return _loading ? Loading() : _errorText();
  }

  Widget _errorText() {
    return Text(
      error,
      style: TextStyle(
        color: Colors.red,
        fontSize: 14.0,
      ),
    );
  }
}
