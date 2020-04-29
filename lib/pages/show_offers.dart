import 'package:flutter/material.dart';

class ShowOffers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "Offers",
              style:
                  TextStyle(fontSize: MediaQuery.of(context).size.width * 0.07),
            ),
          ),
        ),
        Flexible(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => Card(
              elevation: 10.0,
              margin: EdgeInsets.all(10.0),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.26,
                width: MediaQuery.of(context).size.width * 0.25,
                child: Center(
                    child: Text(
                  "Offer $index",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.07,
                  ),
                )),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
