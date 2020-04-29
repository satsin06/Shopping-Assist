import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shopping_assist/models/products.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ShowProduct extends StatefulWidget {
  final String appBartitle;
  final String type;
  ShowProduct({Key key, this.appBartitle, this.type}) : super(key: key);
  @override
  _ShowProductState createState() =>
      _ShowProductState(appBartitle: this.appBartitle, type:this.type);
}

class _ShowProductState extends State<ShowProduct> {
  String appBartitle;
  String type;
  var url = "https://aakash3101.github.io/productDB/groceriesdb.json";
  Product product;
  List<Products> items;

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
      print(product.toJson());
    });
  }

  _ShowProductState({this.appBartitle, this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 18.0,
          title: Text(appBartitle),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.lightGreen,
        body: items == null
            ? Container(
              child: Center(
                  child: CircularProgressIndicator(),
                ),
            )
            : GridView.count(
                childAspectRatio: 9/15 ,
                crossAxisCount: 2,
                children: items.where((p) => p.type == type)
                    .map((item) => Padding(
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
                                        imageUrl: item.image,
                                        placeholder: (context, url) => CircularProgressIndicator(),
                                        height: 200.0,
                                        width: 180.0,
                                      ),
                                      Text(
                                        item.name,
                                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList()));
  }
}
