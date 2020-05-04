import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shopping_assist/models/products.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopping_assist/widgets/counter.dart';
import 'package:shopping_assist/display_widgets/fabcart.dart';

class ShowProduct extends StatefulWidget {
  final String appBartitle;
  final String type;
  ShowProduct({Key key, this.appBartitle, this.type}) : super(key: key);
  @override
  _ShowProductState createState() =>
      _ShowProductState(appBartitle: this.appBartitle, type: this.type);
}

class _ShowProductState extends State<ShowProduct> {
  String appBartitle;
  String type;
  var url = "https://aakash3101.github.io/productDB/groceriesdb.json";
  Product product;
  List<Products> items;
  List<Products> typeItems;
  List count;
  

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);

    setState(() {
      var decodedJson = jsonDecode(res.body);
      product = Product.fromJson(decodedJson);
      items = product.products.toList();
      //print(product.toJson());
      typeItems = items.where((p) => p.type == type).toList();
      count = List.filled(typeItems.length, 0);
    });
  }



  _ShowProductState({this.appBartitle, this.type});

  @override
  Widget build(BuildContext context) {
    int sum = count == null ? 0: count.fold(0, (p, c) => p + c);
    return Scaffold(
        appBar: AppBar(
          elevation: 18.0,
          title: Text(appBartitle),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        floatingActionButton: fabCart(context, sum),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: Colors.lightGreen,
        body: typeItems == null
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : GridView.builder(
                itemCount: typeItems == null ? 0 : typeItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 9 / 16,
                    mainAxisSpacing: 3.0,
                    crossAxisSpacing: 3.0),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: () {},
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        elevation: 12.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            //MediaQuery.of(context).size.width * 0.2,
                            child: Column(
                              children: <Widget>[
                                CachedNetworkImage(
                                  imageUrl: typeItems[index].image,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  height: 190.0,
                                  width: 180.0,
                                ),
                                Text(
                                  typeItems[index].name,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 7.0,
                                ),
                                Text(
                                  "Price: Rs ${typeItems[index].price}",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  child: count[index] == 0
                                      ? SizedBox(
                                          height: 48.0,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.33,
                                          child: RaisedButton(
                                              color: Colors.redAccent,
                                              elevation: 7.0,
                                              textColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0)),
                                              onPressed: () {
                                                setState(() {
                                                  count[index] = 1;
                                                });
                                              },
                                              child: Text(
                                                "Add to Cart",
                                                style:
                                                    TextStyle(fontSize: 18.0),
                                              )),
                                        )
                                      : ListTileItem(
                                          onCountvalue: (counter) {
                                            setState(() {
                                              count[index] = counter;
                                            });
                                          },
                                        ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}