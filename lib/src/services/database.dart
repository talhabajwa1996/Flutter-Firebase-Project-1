import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/brew.dart';
import '../models/user.dart';

class DatabaseService {
  String uid;

  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData(
      {
        'sugars': sugars,
        'name': name,
        'strength': strength,
      },
    );
  }

  // get brews Stream
  /*
    Whenever the data will be updated (or created), this data will be recorded as a snapshot of the stream,
    and can then be updated on the UI (or wherever it's been used)
  */
  // Stream<QuerySnapshot> get brews => brewColllection.snapshots(); //(This statement of for a single snapshot of database)

  // brew list from snapshot
  /*
    Line 34-48 is used instead line 27 because we want a list of brews instead of a single brew snapchot  
  */
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map(
      (doc) {
        //print(doc.data);
        return Brew(
            name: doc.data['name'] ?? '',
            strength: doc.data['strength'] ?? 0,
            sugars: doc.data['sugars'] ?? '0');
      },
    ).toList();
  }

  // user data from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars'],
        strength: snapshot.data['strength']);
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData =>
      brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
}
