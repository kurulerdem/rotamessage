import 'package:flutter/material.dart';
Future<void> showRegisterSuccessDialog() async {
  return showDialog<void>(
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Başarılı ! ..'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Tebrikler Kayıt oldunuz'),
              Text('Şimdi Chat Ekranına yönlendiriliyorsunuz. Giriş yapabilirsiniz ..'),
            ],
          ),
        ),
        actions: <Widget>[
          RaisedButton(
            child: Text('Tamam'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }, context: null,
  );
}