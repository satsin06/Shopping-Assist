import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:shopping_assist/pages/show_cart.dart';
import 'package:shopping_assist/services/authentication.dart';
import 'package:shopping_assist/widgets/provider_widget.dart';

Widget fabCart(BuildContext context, int count) {
  AuthService auth = Provider.of(context).auth;
  return FloatingActionButton(
        child: Badge(
          badgeColor: Colors.amber,
          badgeContent: Text(
            '$count',
            style: TextStyle(color: Colors.black),
          ),
          position: BadgePosition(left: 20.0, bottom: 20.0),
          child: Icon(
            Icons.local_grocery_store,
            size: 30.0,
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowCart(auth: auth)));
        },
        tooltip: "Show Cart",
      );
}