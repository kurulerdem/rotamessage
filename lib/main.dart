import 'package:flutter/material.dart';
import 'package:rota_mesaj/screens/welcome_screen.dart';
import 'package:rota_mesaj/screens/register_screen.dart';
import 'package:rota_mesaj/style/style.dart';

void main() {
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
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController email = new TextEditingController();
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
                    controller: email,
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
                    onPressed: (){
                      print(email.text);
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



