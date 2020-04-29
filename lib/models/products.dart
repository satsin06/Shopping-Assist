class Product {
  List<Products> products;

  Product({this.products});

  Product.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String name;
  String type;
  String image;
  String price;
  String shelf;

  Products({this.name, this.type, this.image, this.price, this.shelf});

  Products.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    image = json['image'];
    price = json['price'];
    shelf = json['shelf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['image'] = this.image;
    data['price'] = this.price;
    data['shelf'] = this.shelf;
    return data;
  }
}
