import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:shopping_assist/pages/show_cart.dart';
import 'package:shopping_assist/pages/show_categories.dart';
import 'package:shopping_assist/pages/show_offers.dart';
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
  int _currentIndex = 0;
  final List<Widget> _children = [ShowOffers(),ShowCategories(),];

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
        title: Text("Shopping Assist"),
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0))),
        elevation: 7.0,
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
      drawerEdgeDragWidth: 100.0,
      drawer: Drawer(
        elevation: 7.0,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.49,
              child: DrawerHeader(
                child: DisplayInfo(),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.lightGreen, Colors.green])),
              ),
            ),
            InkWell(
              splashColor: Colors.lightGreen,
              onTap: () {
                Navigator.of(context).pushNamed('/home');
              },
              child: ListTile(
                title: Text("Home",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    )),
                leading: Icon(Icons.home),
              ),
            ),
            Divider(
              height: 5.0,
              thickness: 2.0,
            ),
            InkWell(
              splashColor: Colors.lightGreen,
              onTap: () {},
              child: ListTile(
                title: Text(
                  'Profile',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                leading: Icon(Icons.person),
              ),
            ),
            Divider(
              height: 5.0,
              thickness: 2.0,
            ),
            InkWell(
              splashColor: Colors.lightGreen,
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
              splashColor: Colors.lightGreen,
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
      floatingActionButton: FloatingActionButton(
        child: Badge(
          badgeContent: Text(
            '5',
            style: TextStyle(color: Colors.white),
          ),
          position: BadgePosition(left: 20.0, bottom: 20.0),
          child: Icon(
            Icons.local_grocery_store,
            size: 30.0,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed('/showcart');
        },
        tooltip: "Show Cart",
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      //floatingActionButtonAnimator: ,
      body: _children[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 50.0,
        buttonBackgroundColor: Colors.green,
        backgroundColor: Colors.white,
        color: Colors.green,
        items: <Widget>[
          Icon(Icons.local_offer),
          Icon(Icons.category),
        ],
        onTap: onTabTapped,
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     type: BottomNavigationBarType.shifting,
      //     elevation: 15.0,
      //     selectedItemColor: Colors.red,
      //     unselectedItemColor: Colors.black45,
      //     onTap: onTabTapped,
      //     currentIndex: _currentIndex,
      //     items: [
      //       BottomNavigationBarItem(
      //           icon: Icon(Icons.local_offer),
      //           title: Text("Offers"),
      //           backgroundColor: Colors.white),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.category),
      //         title: Text("Categories"),
      //       ),
      //     ]),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

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
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.lightGreen, Colors.green],
            tileMode: TileMode.clamp),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 400.0,
            width: 400.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      spreadRadius: 0.0,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 5.0))
                ]),
            child: Center(
                child: Text(
              query,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
            )),
          ),
          SizedBox(
            height: 40.0,
          ),
          Container(
            height: 100.0,
            width: 400.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black38,
                      spreadRadius: 0.0,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 5.0))
                ]),
            child: Center(
                child: Text(
              query,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
            )),
          ),
        ],
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
        onTap: () {
          query = suggestionList[index];
          showResults(
            context,
          );
        },
        leading: Icon(Icons.shopping_basket),
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
