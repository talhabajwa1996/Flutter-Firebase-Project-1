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
    From line 38 to line 48, a List containing name, strength and sugar will be recorded
    as a new user comes in, converted into a stream(in get brews section) of brews and
    will be taken as a value by the StreamProvider in the home Page which will then be accessed by the Provider
    in the brew_list page to provider the name, strength and sugar to be used as per demand.
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