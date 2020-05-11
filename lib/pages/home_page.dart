import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:shopping_assist/models/products.dart';
import 'package:shopping_assist/pages/show_categories.dart';
import 'package:shopping_assist/pages/show_offers.dart';
import 'package:shopping_assist/services/authentication.dart';
import 'package:shopping_assist/display_widgets/fabcart.dart';
import 'package:shopping_assist/display_widgets/profileview.dart';
import 'package:shopping_assist/display_widgets/drawerprofile.dart';

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
  var url = "https://aakash3101.github.io/productDB/groceriesdb.json";
  int _currentIndex = 0;
  
  List<String> itemNames;
  
  List<Products> itemList;
  
  final List<Widget> _children = [
    ShowOffers(),
    ShowCategories(),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    createList();
  }

  createList() async {
    Product product;
    List<Products> items;
    List<String> productNames;
    var res = await http.get(url);
    setState(() {
      var decode = jsonDecode(res.body);
      product = Product.fromJson(decode);
      items = product.products.toList();

      productNames = items.map((p) => p.name).toList();
    });
    itemNames = productNames;
    itemList = items;
  }

  @override
  void dispose() {
    super.dispose();
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
              showSearch(
                  context: context,
                  delegate: SearchBar(items: itemNames, itemList: itemList));
            },
          )
        ],
      ),
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
                Navigator.pop(context);
                //Navigator.of(context).pushNamed('/home');
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
              onTap: () {
                setState(() {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ProfileView()));
                });
              },
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
                  'My Orders',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                leading: Icon(Icons.local_mall),
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
      floatingActionButton: fabCart(context, 3),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      //floatingActionButtonAnimator: ,
      body: IndexedStack(
        children: _children,
        index: _currentIndex,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 7.0),
        child: CurvedNavigationBar(
          index: _currentIndex,
          height: MediaQuery.of(context).size.height * 0.06, //50.0,
          buttonBackgroundColor: Colors.green,
          backgroundColor: Colors.white,
          color: Colors.green,
          items: <Widget>[
            Icon(Icons.local_offer),
            Icon(Icons.category),
          ],
          onTap: onTabtapped
        ),
      ),
    );
  }

  void onTabtapped (int index) {
    setState(() {
      _currentIndex = index;
      //_pageController.jumpToPage(index);
    });
  }
}


class SearchBar extends SearchDelegate<String> {
  List<String> items = [];
  List<Products> itemList;
  SearchBar({this.items, this.itemList});

  final recentItems = [
    "Potato",
    "DairyMilk Silk",
    "Maggi",
    "Mushrooms",
    "Red Label: Tea",
    "Bru: Instant Coffee",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
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
    Products item;
    item = itemList.singleWhere((p) => p.name == query);
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.lightGreen, Colors.green],
            tileMode: TileMode.clamp),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                        spreadRadius: 2.0,
                        blurRadius: 6.0,
                        offset: Offset(0.0, 10.0))
                  ]),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child: Image.network(
                      item.image,
                      height: MediaQuery.of(context).size.height * 0.32,
                      width: MediaQuery.of(context).size.width * 0.47,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    item.name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 27.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Container(
              height: 100.0,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                        spreadRadius: 1.0,
                        blurRadius: 6.0,
                        offset: Offset(0.0, 10.0))
                  ]),
              child: Center(
                  child: Text(
                query,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35.0),
              )),
            ),
          ],
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















// PageView(
//       controller: _pageController,
//       children: <Widget>[ShowOffers(), ShowCategories()],
//       onPageChanged: onTabtapped
//     )
//Bottom Navigation Bar
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
