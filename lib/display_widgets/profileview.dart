import 'package:flutter/material.dart';
import 'package:shopping_assist/widgets/provider_widget.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Profile"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
              //Navigator.of(context).pushNamed("/home");
            },
          ),
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0))),
          elevation: 7.0),
      body: Center(
        child: FutureBuilder(
          future: Provider.of(context).auth.getCurrentUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done)
              return displayInfo(context, snapshot);
            else if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
          },
        ),
      ),
    );
  }
}

Widget displayInfo(context, snapshot) {
  final user = snapshot.data;
  if (user.photoUrl == null) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CircleAvatar(
          maxRadius: 60.0,
          child: Icon(
            Icons.person,
            size: 60.0,
          ),
          backgroundColor: Colors.indigo,
        ),
        SizedBox(
          height: 50.0,
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            "${user.displayName}",
            style: TextStyle(
                fontSize: 35.0,
                color: Colors.white,
                fontWeight: FontWeight.w900),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            "${user.email}",
            style: TextStyle(fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.w700),
          ),
        )
      ],
    );
  } else {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: CircleAvatar(
            maxRadius: 60.0,
            backgroundImage: NetworkImage(user.photoUrl),
          ),
        ),
        SizedBox(
          height: 50.0,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "${user.displayName}",
            style: TextStyle(
                fontSize: 35.0,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "${user.email}",
            style: TextStyle(fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.w300),
          ),
        )
      ],
    );
  }
}
