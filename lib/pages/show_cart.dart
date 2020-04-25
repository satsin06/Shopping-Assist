import 'package:flutter/material.dart';

class ShowCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Your Cart Orders",
          style: TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
