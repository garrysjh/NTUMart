import 'dart:convert';


List<Listing> parseListings(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Listing>((json) => Listing.fromJson(json)).toList();
}

class FileData {
  final String fileName;
  final String fileType;
  final String content;

  

  FileData({required this.fileName, required this.fileType, required this.content});

  factory FileData.fromJson(Map<String, dynamic> json) {
    return FileData(
      fileName: json['fileName'],
      fileType: json['fileType'],
      content: json['content'],
    );
  }
}

class Listing {
  final String sellerName;
  final String productName;
  final String description;
  final double price;
  final int quantity;
  final List<FileData> productImages;
  final int productLikes;
  final DateTime date;
  final String category;

  String? getProductPic() {
    // Implement logic to get the product picture.
    // For example, return the URL of the first image, if available.
    if (productImages.isNotEmpty) {
      return productImages[0].content;
    } else {
      return null;
    }
  }

  Listing({
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

  

  factory Listing.fromJson(Map<String, dynamic> json) {
    return Listing(
      sellerName: json['sellerName'],
      productName: json['productName'],
      description: json['description'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      productImages: List<FileData>.from(json['productImages'].map((image) => FileData.fromJson(image))),
      productLikes: json['productLikes'],
      date: DateTime.parse(json['date']),
      category: json['category'],
    );
  }
}