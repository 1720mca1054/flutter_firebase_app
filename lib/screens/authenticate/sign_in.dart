import 'package:firebaseflutter/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('SignIn'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Center(
          child: RaisedButton(
            child: Text('Sigin'),
            onPressed: () async {
              dynamic result =  await _auth.signInAnonymously();

              if(result == null){
                print('error signing in');
              }
              else {
                print('signin successful');
                print(result.uid);
              }
            },
          ),
        ),
      ),
    );
  }
}
