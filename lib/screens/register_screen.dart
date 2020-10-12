import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rota_mesaj/alerts/alert.dart';
import 'package:rota_mesaj/main.dart';
import 'package:rota_mesaj/screens/welcome_screen.dart';
import 'package:rota_mesaj/style/style.dart';
import 'chatscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class RegisterScreen extends StatefulWidget {
  static String id = 'register_screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _auth = FirebaseAuth.instance;
String email;
String password;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text('Üye Olun'),
          ),
          body: Container(
              color: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0,3),
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.fromLTRB(30, 5, 30, 7),
                    child: Container(

                      child: TextField(
                        onChanged: (value){
                          email = value;
                        },
                        style: registerinputtext,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          hoverColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.white)
                          ),
                          hintText: 'Email adresinizi giriniz !',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0,3),
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.fromLTRB(30, 5, 30, 7),
                    child: Container(

                      child: TextField(
                        onChanged: (value){
                            password = value;
                        },
                        obscureText: true,
                        style: registerinputtext,
                        decoration: InputDecoration(
                          fillColor: Colors.green,
                          focusColor: Colors.red,
                          hoverColor: Colors.blue,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.tealAccent)
                          ),
                          hintText: 'Şifrenizi giriniz !',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60)
                    ),
                    width: 300,
                    height: 40,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)
                      ),
                      onPressed: () async{
                        try {
                          final newuser =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
                              Navigator.pushNamed(context, MyHomePage.id);

                              if(true) {
                                _onBasicAlertPressed(context);
                              }

                          }

                     catch(e){
                          print(e);
                     }
                      },
                      child: Text('Üye Ol',style: signupbutton,),

                    ),
                  ),
                ],
              ),
            ),
          ),
      );
  }
}
_onBasicAlertPressed(context) {
  Alert(
    context: context,
    title: "Başarılı",
    desc: "Başarı ile üye oldunuz",
  ).show();
}