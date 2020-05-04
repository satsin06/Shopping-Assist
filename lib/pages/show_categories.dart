import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_assist/display_widgets/show_products.dart';

class ShowCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "Categories",
              style: GoogleFonts.courgette(
                  fontSize: MediaQuery.of(context).size.width * 0.08),
            ),
          ),
        ),
        Flexible(
          child: ListView(
            children: <Widget>[
              InkWell(
                splashColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ShowProduct(appBartitle: "Fruits", type: "fruits",)),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 10.0,
                  margin: EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                            colors: [Colors.red, Colors.pinkAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            tileMode: TileMode.mirror)),
                    height: MediaQuery.of(context).size.height * 0.26,
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: Center(
                        child: Text(
                      "Fruits",
                      style: GoogleFonts.charmonman(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.07,
                      ),
                    )),
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ShowProduct(appBartitle: "Vegetables", type: "vegetables",)),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 10.0,
                  margin: EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                            colors: [Colors.green[500], Colors.lightGreen],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            tileMode: TileMode.mirror)),
                    height: MediaQuery.of(context).size.height * 0.26,
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: Center(
                        child: Text(
                      "Vegetables",
                      style: GoogleFonts.charmonman(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.07,
                      ),
                    )),
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ShowProduct(appBartitle: "Bakery, Cakes & Dairy", type: "dairy",)),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 10.0,
                  margin: EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                            colors: [Colors.purple, Colors.blueAccent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            tileMode: TileMode.mirror)),
                    height: MediaQuery.of(context).size.height * 0.26,
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: Center(
                        child: Text(
                      "Bakery, Cakes & Dairy",
                      style: GoogleFonts.charmonman(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.07,
                      ),
                    )),
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ShowProduct(appBartitle: "Beverages", type: "beverages",)),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 10.0,
                  margin: EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                            colors: [Colors.blueAccent, Colors.black],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            tileMode: TileMode.mirror)),
                    height: MediaQuery.of(context).size.height * 0.26,
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: Center(
                        child: Text(
                      "Beverages",
                      style: GoogleFonts.charmonman(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.07,
                      ),
                    )),
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ShowProduct(appBartitle: "Foodgrains, Oil & Masala", type: "foodgrain",)),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 10.0,
                  margin: EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                            colors: [Colors.deepOrange, Colors.amber],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            tileMode: TileMode.mirror)),
                    height: MediaQuery.of(context).size.height * 0.26,
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: Center(
                        child: Text(
                      "Foodgrains, Oil & Masala",
                      style: GoogleFonts.charmonman(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.07,
                      ),
                    )),
                  ),
                ),
              ),
              InkWell(
                splashColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ShowProduct(appBartitle: "Gourmet & World Food", type: "gourmet",)),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 10.0,
                  margin: EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: LinearGradient(
                            colors: [Colors.pink, Colors.blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            tileMode: TileMode.mirror)),
                    height: MediaQuery.of(context).size.height * 0.26,
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: Center(
                        child: Text(
                      "Gourmet & World Food",
                      style: GoogleFonts.charmonman(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.07,
                      ),
                    )),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
