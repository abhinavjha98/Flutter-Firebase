import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/brew.dart';
import 'package:flutter_firebase/models/user.dart';

class DataBaseService {
  final String uid;

  final CollectionReference brewCollection =
      Firestore.instance.collection("brews");

  DataBaseService({this.uid});

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .document(uid)
        .setData({'sugars': sugars, 'name': name, 'strength': strength});
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
          name: doc.data['name'] ?? "",
          sugars: doc.data['sugars'] ?? "",
          strength: doc.data['strength'] ?? 0);
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'] ?? "",
        sugars: snapshot.data['sugars'] ?? "",
        strength: snapshot.data['strength'] ?? 0);
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
