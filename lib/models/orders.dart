import 'package:firebase_database/firebase_database.dart';

class Orders {
  String key;
  String userId;
  int totalAmount;
  int totalQty;
  String date;
  String time;
  List<CartItems> cartItems;

  Orders({this.userId, this.totalAmount, this.totalQty, this.date, this.time, this.cartItems});

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      userId: json["userId"],
      totalAmount: json["totalAmount"],
      totalQty: json["totalQty"],
      date: json["date"],
      time: json["time"],
      cartItems: json["cartItems"]
    );
  }

  Orders.fromSnapshot(DataSnapshot snapshot):
    key = snapshot.key,
    userId = snapshot.value["userId"],
    totalAmount = snapshot.value["totalAmount"],
    totalQty = snapshot.value["totalQty"],
    date = snapshot.value["date"],
    time = snapshot.value["time"],
    cartItems = snapshot.value["cartItems"];
  
  toJson() {
    return {
      "userId": userId,
      "totalAmount": totalAmount.toString(),
      "totalQty": totalQty.toString(),
      "date": date,
      "time": time,
      "cartItems": cartItems
    };
  }
}

class CartItems {
  String prodName;
  int prodQty;
  String prodPrice;

  CartItems({this.prodName, this.prodQty, this.prodPrice});

  CartItems.fromSnapshot(DataSnapshot snapshot):
  prodName = snapshot.value["prodName"],
  prodPrice = snapshot.value["prodPrice"],
  prodQty = snapshot.value["prodQty"];

  toJson() {
    return {
      "prodName": prodName,
      "prodPrice": prodPrice,
      "prodQty": prodQty.toString()
    };
  }
}

// Orders.fromJson(Map<String, dynamic> json) {
//     userId = json['userId'];
//     totalAmount = json['totalAmount'];
//     date = json['date'];
//     time = json['time'];
//     if (json['cartItems'] != null) {
//       cartItems = new List<CartItems>();
//       json['cartItems'].forEach((v) {
//         cartItems.add(new CartItems.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['userId'] = this.userId;
//     data['totalAmount'] = this.totalAmount;
//     data['date'] = this.date;
//     data['time'] = this.time;
//     if (this.cartItems != null) {
//       data['cartItems'] = this.cartItems.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }

// CartItems.fromJson(Map<String, dynamic> json) {
//     prodName = json['prodName'];
//     prodQty = json['prodQty'];
//     prodPrice = json['prodPrice'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['prodName'] = this.prodName;
//     data['prodQty'] = this.prodQty;
//     data['prodPrice'] = this.prodPrice;
//     return data;
//   }
