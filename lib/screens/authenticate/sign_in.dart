import 'package:firebaseflutter/services/auth.dart';
import 'package:firebaseflutter/shared/constants.dart';
import 'package:firebaseflutter/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final AuthService _auth = AuthService();
  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('SignIn'),
        actions: <Widget>[
          FlatButton.icon(
            icon:Icon(Icons.person),
            label: Text('Register'),
            onPressed: (){

              widget.toggleView();

            },
          )],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
          child: /*Center(
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
          ),*/
          Form(
            key: _formKey,

            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),

                  validator: (val) => val.isEmpty ? 'Enter an Email' : null,

                  onChanged: (val){
                    setState(() => email= val);
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),

                  validator: (val) => val.length < 6 ? 'Enter at least 7 chars long password' : null,

                  obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);

                  },
                ),
                SizedBox(height: 20.0,),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text('SignIn', style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(() => loading = true);

                      dynamic result = await _auth.signinWithEmailAndPassword(email, password);

                      if(result == null){
                        setState((){
                          error = 'Could not sign in with those credentials';
                          loading = false;
                        });
                      }

                    }
                  },
                ),
                SizedBox(height: 10.0,),
                Text(error,style: TextStyle(color: Colors.red,fontSize: 14.0),),

              ],
            ),
          )
        ),
      ),
    );
  }
}
