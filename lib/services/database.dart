import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseflutter/models/brew.dart';
import 'package:firebaseflutter/models/user.dart';


class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference brewCollection = Firestore.instance.collection('brew');

  Future updateUserData(String sugars,String name,int strength) async{
    //collection reference
    return await brewCollection.document((uid)).setData({'sugars':sugars, 'name': name, 'strenght': strength});

  }

  //brew list from snapshot

  List<Brew> _brewListFromSnapShot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 100,
        sugar:  doc.data['suger'] ?? '0'
      );
    }).toList();
  }

  //userdata from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
        name: snapshot.data['name'],
      sugars: snapshot.data['sugar'],
      strength: snapshot.data['strength']
    );
  }

//get stream
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots().map(_brewListFromSnapShot);
  }


  Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }


}