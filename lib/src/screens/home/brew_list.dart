import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/brew.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

  final brews = Provider.of<List<Brew>>(context) ?? [];
    
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index){
        return _brewTile(brews[index]);
      },
    );
  }

  Widget _brewTile(Brew brew){
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}