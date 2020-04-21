import 'package:flutter/material.dart';
import 'package:shopping_assist/services/authentication.dart';
import 'package:shopping_assist/widgets/provider_widget.dart';

class HomePage extends StatefulWidget {
  
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
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              showSearch(context: context, delegate: SearchBar());
            },
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

class SearchBar extends SearchDelegate<String> {
  final items = [
    "Milk",
    "Cheese",
    "Paneer",
    "Curd",
    "Biscuits",
    "Lays",
    "Kurkure",
    "Frooti",
    "Coca Cola",
    "Fanta",
    "Pepsi",
    "ThumsUp",
    "Wheat Flour",
    "Maze Flour",
    "Lentils",
    "Beans",
    "Corn",
    "Chocolates",
    "Cereal",
    "Oats",
    "Tea",
    "Coffee",
    "Namkeen",
    "Utensils",
    "Culinery",
    "Deodorants",
    "Perfumes",
    "Soaps",
    "Shampoos",
    "Hair Conditioner",
    "Handwash",
    "Detergents",
    "Liquid Soap",
    "Ghee",
    "Refined Oil",
    "Olive Oil"
  ];

  final recentItems = [
    "Corn",
    "Chocolates",
    "Cereal",
    "Oats",
    "Tea",
    "Coffee",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white24,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.deepOrange, Colors.orangeAccent],
                tileMode: TileMode.mirror),
          ),
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentItems
        : items
            .where((p) => p.toLowerCase().contains(query.toLowerCase()))
            .toList(); // displays items which contain the query string
    //: items.where((p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();         // displays items which start with the query string

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: (){
          query = suggestionList[index];
          showResults(context,);
        },
        leading: Icon(Icons.shopping_cart),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey))
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
