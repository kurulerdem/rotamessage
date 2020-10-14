import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rota_mesaj/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseUser loggedInUser;
final _firestore = Firestore.instance;
class ChatScreen extends StatefulWidget {
  static String id = "chat_screen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _auth = FirebaseAuth.instance;
  String messageText;
  // ignore: deprecated_member_use
  FirebaseUser loggedInUser;

  final messageTextController = new TextEditingController();

  void initState() {
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser () async{
    try {
      final user = await _auth.currentUser;
      if ( user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }
  void messagesStream() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for(var message in snapshot.documents){
        print(message.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
              }),
        ],
        title: Text('Sohbet Ekranı'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //Implement send functionality.
                      messageTextController.clear();
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': _auth.currentUser.email,
                      });


                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightGreen,
            ),
          );
        }
        final messages = snapshot.data.documents;
        List<MessageKutusu> mesajKutulari = [];
        // ignore: missing_return
        for(var message in messages) {
          final messageText = message.data()['text'];
          final messageSender = message.data()['sender'];
          final mesajKutusu = MessageKutusu(sender: messageSender, text: messageText);
          mesajKutulari.add(mesajKutusu);
        }
        return Expanded(
          child: ListView (
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
            children: mesajKutulari,
          ),
        );
      },
    );
  }
}


class MessageKutusu extends StatelessWidget {
  MessageKutusu({this.sender,this.text});

  final String sender;
  final String text;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(sender,style: TextStyle(
            fontSize: 12.0,
            color: Colors.black54,
          )),
          Material(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: Colors.lightBlueAccent,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: Text(text,style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0
                ),),
              )),
        ],
      ),
    );

  }
}
