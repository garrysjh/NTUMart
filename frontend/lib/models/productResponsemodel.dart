class ProductResponse {
  String? productName;
  String? description;
  double? price;
  int? quantity;
  String? productPic;
  String? productPic2;
  String? productPic3;
  String? productPic4;
  List<String?>? binaryImageDataList;

  ProductResponse({
    this.productName,
    this.description,
    this.price,
    this.quantity,
    this.productPic,
    this.productPic2,
    this.productPic3,
    this.productPic4,
    List<String?>? binaryImageDataList,
  }) : binaryImageDataList = binaryImageDataList ?? [productPic, productPic2, productPic3, productPic4];

  // Getters
  String? get getProductName => productName;
  String? get getDescription => description;
  double? get getPrice => price;
  int? get getQuantity => quantity;
  String? get getProductPic => productPic;
  String? get getProductPic2 => productPic2;
  String? get getProductPic3 => productPic3;
  String? get getProductPic4 => productPic4;
  List<String?>? get getBinaryImageDataList => binaryImageDataList;

  // Setters
  set setProductName(String? value) => productName = value;
  set setDescription(String? value) => description = value;
  set setPrice(double? value) => price = value;
  set setQuantity(int? value) => quantity = value;
  set setProductPic(String? value) => productPic = value;
  set setProductPic2(String? value) => productPic2 = value;
  set setProductPic3(String? value) => productPic3 = value;
  set setProductPic4(String? value) => productPic4 = value;
  set setBinaryImageDataList(List<String?>? value) => binaryImageDataList = value ?? [productPic, productPic2, productPic3, productPic4];

// Additional constructor to create an instance from a map
  ProductResponse.fromMap(Map<String, dynamic> productData)
      : productName = productData["productName"] ?? '',
        description = productData["description"] ?? '',
        price = productData["price"]?.toDouble() ?? -1.0,
        quantity = productData["quantity"]?.toInt() ?? -1,
        productPic = productData["productImages"][0]["content"] ?? '',
        productPic2 = productData["productImages"][1]["content"] ?? '',
        productPic3 = productData["productImages"][2]["content"] ?? '',
        productPic4 = productData["productImages"][3]["content"] ?? '',
        binaryImageDataList = [
          productData["productImages"][0]["content"] ?? '',
          productData["productImages"][1]["content"] ?? '',
          productData["productImages"][2]["content"] ?? '',
          productData["productImages"][3]["content"] ?? '',
        ];

}