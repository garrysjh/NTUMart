import 'dart:convert';

List<Listing> parseListings(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Listing>((json) => Listing.fromJson(json)).toList();
}

class Listing {
  int? productId;
  int? sellerId;
  String? name;
  String? description;
  double? price;
  int? quantity;
  String? productPic;
  String? category = 'test';

  Listing(
      {this.productId,
      this.sellerId,
      this.name = 'empty',
      this.description = 'empty',
      this.price = 0,
      this.quantity = 0,
      this.productPic = 'was empty',
      this.category = 'empty'});

  getProductPic() {
    return productPic;
  }

  Listing.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    sellerId = json['sellerId'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    quantity = json['quantity'];
    productPic = json['productPic'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['sellerId'] = sellerId;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['quantity'] = quantity;
    data['productPic'] = productPic;
    data['category'] = category;
    return data;
  }
}
