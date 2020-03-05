import 'package:firebaseflutter/services/auth.dart';
import 'package:firebaseflutter/shared/constants.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('SignUp'),
        actions: <Widget>[
          FlatButton.icon(
              icon:Icon(Icons.person),
            label: Text('SignIn'),
            onPressed: (){
                widget.toggleView();
            },
          )],
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
            child:
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
                    child: Text('SignUp', style: TextStyle(color: Colors.white),),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){

                        dynamic result = await _auth.registerWithEmailAndPassword(email,password);
                        if(result == null){
                          setState(() =>error = 'please give valid email');
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
