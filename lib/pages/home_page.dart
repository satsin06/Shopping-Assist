import 'package:flutter/material.dart';
import 'package:shopping_assist/services/authentication.dart';

class HomePage extends StatefulWidget {
  // TODO

  final AuthService auth;
  HomePage({Key key, this.auth}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(auth: this.auth);
}

class _HomePageState extends State<HomePage> {
  AuthService auth;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  _HomePageState({this.auth});

  // @override
  // void dispose() {
  //   super.dispose();
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Assist'),
        actions: <Widget>[
          Row(
            children: <Widget>[
              FlatButton(
                child: Icon(
                  Icons.power_settings_new,
                  color: Colors.white,
                ),
                onPressed: (){
                  try {
                    auth.signOut();
                  } catch(e){
                    print(e);
                  }
                },
              )
            ],
          )
        ],
      ),
      body: Center(
          child: Text(
        "Hey There",
        textScaleFactor: 2.0,
      )),
    );
  }
}
