import 'package:Firebase_Project_1/src/models/user.dart';
import 'package:Firebase_Project_1/src/services/database.dart';
import 'package:Firebase_Project_1/src/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../shared/constants.dart';

class SettingsPane extends StatefulWidget {
  @override
  _SettingsPaneState createState() => _SettingsPaneState();
}

class _SettingsPaneState extends State<SettingsPane> {
  var _formKey = GlobalKey<FormState>();
  List<String> sugars = ['0','1', '2', '3', '4', '5'];

  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          UserData userData = snapshot.data;
          return FlatButton.icon(
          icon: Icon(Icons.settings),
          label: Text('Settings'),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                margin: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _title(),
                      SizedBox(height: 8.0),
                      _nameField(userData.name),
                      SizedBox(height: 8.0),
                      _selectSugar(userData.sugars),
                      SizedBox(height: 8.0),
                      _selectStrength(userData.strength),
                      Text('Select strengh'),
                      SizedBox(height: 8.0),
                      _submitButton(user.uid, userData.name, userData.sugars, userData.strength),
                    ],
                  ),
                ),
              ),
            );
          },
        );
        }
        else{
          return Loading();
        }
      }
    );
  }

  Widget _title() {
    return Text(
      'BrewSettings',
      style: TextStyle(fontSize: 20.0),
    );
  }

  Widget _nameField(String userName) {
    return TextFormField(
      initialValue: userName,
      decoration: inputFieldsDecoration.copyWith(hintText: 'Name'),
      validator: (name) => name.isEmpty ? 'Enter a name' : null,
      keyboardType: TextInputType.text,
      onChanged: (value) => setState(() => _currentName = value),
    );
  }

  Widget _selectSugar(String userSugars) {
    return DropdownButtonFormField(
      value: _currentSugar ?? userSugars,
      hint: Text('Select sugar'),
      decoration: inputFieldsDecoration,
      items: sugars
          .map(
            (sugar) => DropdownMenuItem(
              value: sugar,
              child: Text('$sugar sugars'),
            ),
          )
          .toList(),
      onChanged: (value) => setState(() => _currentSugar = value),
    );
  }

  Widget _selectStrength(int userStrength) {
    return Slider(
      
      value: (_currentStrength ?? userStrength).toDouble(),
      activeColor: Colors.brown[_currentStrength ?? 100],
      min: 100.0,
      max: 900.0,
      divisions: 8,
      onChanged: (value) => setState(() => _currentStrength = value.round()),
    );
  }

  Widget _submitButton(String uid, String userName, String userSugar, int userStrength) {
    return RaisedButton(
      child: Text('Submit'),
      onPressed: () async {
        if (_formKey.currentState.validate()){
          await DatabaseService(uid: uid).updateUserData(
            _currentSugar ?? userSugar,
            _currentName ?? userName,
            _currentStrength ?? userStrength,
            );
            Navigator.pop(context);
        }
      },
    );
  }
}
