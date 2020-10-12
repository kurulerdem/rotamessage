import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rota_mesaj/screens/chatscreen.dart';
import 'package:rota_mesaj/screens/welcome_screen.dart';
import 'package:rota_mesaj/screens/register_screen.dart';
import 'package:rota_mesaj/style/style.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
      routes: {
        WelcomeScreen.id:(context) => WelcomeScreen(),
        RegisterScreen.id:(context) => RegisterScreen(),
        MyHomePage.id:(context) => MyHomePage(),
        ChatScreen.id:(context) => ChatScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  static String id = "homepage_screen";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: CircleAvatar(
                        radius: 40,
                        child: Image(
                          image: AssetImage('assets/images/rotamessage_logo.png'),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      alignment: Alignment.center,
                        child: Text('ROTA MESSAGE',style: heading,)),
                  ],
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
                  child: TextField(
                    onChanged: (value){
                      email = value;
                    },
                    style: inputtext,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                    ),
                      hintText: 'Email adresinizi giriniz !',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
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
                  child: TextField(
                    onChanged: (value){
                      password = value;
                    },
                    style: inputtext,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Şifrenizi Giriniz !',
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60)
                  ),
                  width: 170,
                  height: 40,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)
                    ),
                    child: Text('Giriş Yap',style: butontext,),
                    onPressed: () async{
                      // Login function
                      try {
                        final user = await _auth.signInWithEmailAndPassword(email: email, password: password);

                          Navigator.pushNamed(context, ChatScreen.id);


                      }
                         catch(e) {
                            print(e);
                         }

                    },

                  ),
            ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60)
                    ),
                    width: 100,
                    height: 40,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)
                      ),
                      onPressed: (){
                            Navigator.pushNamed(context, RegisterScreen.id);
                      },
                      child: Text('Üye Ol',style: signupbutton,),

                    ),
                  ),
                ],
              ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: FlatButton(
                    onPressed: (){},
                    child: Text('Giriş yaparken sorun mu yaşıyorsunuz ?',style: inputtext,),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}



