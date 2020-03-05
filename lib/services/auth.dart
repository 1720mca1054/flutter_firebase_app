import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseflutter/models/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
//user object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user){
    return user!= null? User(uid: user.uid):null;
  }

//auth change user stream
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //Sign in anonymously
  Future signInAnonymously() async{
    try{
    AuthResult result =  await _auth.signInAnonymously();
    FirebaseUser user = result.user;
    return _userFromFirebaseUser(user);
    }catch(e){
      print((e.toString()));
      return null;
    }
  }

  //sign in with email

  Future signinWithEmailAndPassword(String email,String password) async {

    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }

  }

  //register with email

  Future registerWithEmailAndPassword(String email,String password) async {

    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }

  }

  //sign out

Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
}

}