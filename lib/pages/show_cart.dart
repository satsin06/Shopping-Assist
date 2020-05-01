import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shopping_assist/models/orders.dart';
//import 'package:shopping_assist/models/products.dart';
//import 'package:shopping_assist/pages/show_categories.dart';
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

  //final FirebaseDatabase _database = FirebaseDatabase.instance;
  List<Orders> _ordersList;

  // StreamSubscription<Event> _onOrdersChanged;
  // StreamSubscription<Event> _onOrdersAdded;
  // Query _ordersQuery;

  @override
  void initState() {
    super.initState();
    // _ordersList = List();
    // _ordersQuery = _database
    //     .reference()
    //     .child("orders")
    //     .orderByChild("userId")
    //     .equalTo(auth.getCurrentUID());

    // _onOrdersAdded = _ordersQuery.onChildAdded.listen(onEntryAdded);
    // _onOrdersChanged = _ordersQuery.onChildChanged.listen(onEntryChanged);
  }

  @override
  void dispose() {
    // _onOrdersAdded.cancel();
    // _onOrdersChanged.cancel();
    super.dispose();
  }

  _ShowCartState({this.auth});

  onEntryChanged(Event event) {
    var oldEntry = _ordersList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _ordersList[_ordersList.indexOf(oldEntry)] =
          Orders.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _ordersList.add(Orders.fromSnapshot(event.snapshot));
    });
  }

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
