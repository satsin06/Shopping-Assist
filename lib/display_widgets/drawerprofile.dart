import 'package:flutter/material.dart';
import 'package:shopping_assist/widgets/provider_widget.dart';

class DisplayInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FutureBuilder(
            future: Provider.of(context).auth.getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return displayinfo(context, snapshot);
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}

Widget displayinfo(context, snapshot) {
  final user = snapshot.data;
  if (user.photoUrl == null) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          maxRadius: 45.0,
          child: Icon(
            Icons.person,
            size: 45.0,
          ),
          backgroundColor: Colors.indigo,
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 2.0),
          child: Text(
            "${user.displayName}",
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 5.0),
          child: Text(
            "${user.email}",
            style: TextStyle(fontSize: 13.0, color: Colors.white),
          ),
        )
      ],
    );
  } else {
    return Column(
      children: <Widget>[
        CircleAvatar(
          maxRadius: 45.0,
          backgroundImage: NetworkImage(user.photoUrl),
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
          child: Text(
            "${user.displayName}",
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          child: Text(
            "${user.email}",
            style: TextStyle(fontSize: 15.0, color: Colors.white),
          ),
        )
      ],
    );
  }
}