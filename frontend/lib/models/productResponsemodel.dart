class ProductResponse{
  String? productName;
  String? description;
  double? price;
  int? quantity;
  String? productPic;
  String? productPic2;
  String? productPic3;
  String? productPic4;

  List<String?> generateBinaryImageList{
    List binaryImageDataList = [productPic, productPic2, productPic3, productPic4];
    return binaryImageDataList;
}