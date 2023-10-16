import 'file_data.dart'; // Import the FileData class if it exists

class ProductResponse {
  late String sellerName;
  late String productName;
  late String description;
  late double price;
  late int quantity;
  late List<FileData> productImages;
  late int productLikes;
  late DateTime date;
  late String category;

  ProductResponse({
    required this.sellerName,
    required this.productName,
    required this.description,
    required this.price,
    required this.quantity,
    required this.productImages,
    required this.productLikes,
    required this.date,
    required this.category,
  });

  // Named constructor for creating an instance from JSON data
  ProductResponse.fromJson(Map<String, dynamic> json) {
    sellerName = json['sellerName'];
    productName = json['productName'];
    description = json['description'];
    price = json['price'].toDouble();
    quantity = json['quantity'];
    productImages = List<FileData>.from(json['productImages'].map((x) => FileData.fromJson(x)));
    productLikes = json['productLikes'];
    date = DateTime.parse(json['date']);
    category = json['category'];
  }

  // Method to convert the object to a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'sellerName': sellerName,
      'productName': productName,
      'description': description,
      'price': price,
      'quantity': quantity,
      'productImages': productImages.map((x) => x?.toJson()).toList(),
      'productLikes': productLikes,
      'date': date.toIso8601String(),
      'category': category,
    };
  }
}