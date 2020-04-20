import 'package:flutter/material.dart';
import 'package:shopping_assist/services/authentication.dart';
import 'package:shopping_assist/widgets/provider_widget.dart';

class HomePage extends StatefulWidget {
  // TODO

  final AuthService auth;
  HomePage({
    Key key,
    this.auth,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(
        auth: this.auth,
      );
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

  _HomePageState({
    this.auth,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Row(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(
                      right: 10.0, bottom: 1.0, top: 1.0, left: 3.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Search here", style: TextStyle(fontSize: 16.0, color: Colors.black)),
                      ),
                      SizedBox(width: 185.0,),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          )
        ],
      ),
      drawer: Drawer(
        elevation: 7.0,
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: DisplayInfo(),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.green.shade900, Colors.green])),
            ),
            InkWell(
              splashColor: Colors.greenAccent,
              onTap: () {},
              child: ListTile(
                title: Text("Home",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    )),
                leading: Icon(Icons.home),
              ),
            ),
            InkWell(
              splashColor: Colors.greenAccent,
              onTap: () {},
              child: ListTile(
                title: Text(
                  'Profile',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                leading: Icon(Icons.person),
              ),
            ),
            InkWell(
              splashColor: Colors.greenAccent,
              onTap: () {},
              child: ListTile(
                title: Text(
                  'Settings',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                leading: Icon(Icons.settings),
              ),
            ),
            Divider(
              height: 5.0,
              thickness: 2.0,
            ),
            InkWell(
              splashColor: Colors.greenAccent,
              onTap: () {
                try {
                  auth.signOut();
                } catch (e) {
                  print(e);
                }
              },
              child: ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                leading: Icon(Icons.arrow_back),
              ),
            ),
          ],
        ),
      ),
      body: Center(
          child: Text(
        "Hey There",
        textScaleFactor: 2.0,
      )),
    );
  }
}

class DisplayInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
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
          maxRadius: 35.0,
          child: Icon(
            Icons.person,
            size: 35.0,
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
          maxRadius: 35.0,
          backgroundImage: NetworkImage(user.photoUrl),
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
  }
}
