import 'package:flutter/material.dart';
import 'package:shopping_assist/services/authentication.dart';

class ShowCart extends StatefulWidget {
  final AuthService auth;
  ShowCart({
    Key key,
    this.auth,
  }) : super(key: key);
  @override
  _ShowCartState createState() => _ShowCartState(auth: this.auth);
}

class _ShowCartState extends State<ShowCart> {
  AuthService auth;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _ShowCartState({this.auth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0))),
        elevation: 7.0,
      ),
      body: Container(
        child: Center(
          child: Text(
            "Your Cart Orders",
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.check),
        label: Text('Checkout'),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
