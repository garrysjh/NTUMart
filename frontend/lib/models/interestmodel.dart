class Interest {
  int userID;
  String category1;
  String? category2;
  String? category3;
  String? category4;
  String? category5;

  Interest({
    required this.userID,
    required this.category1,
    required this.category2,
    required this.category3,
    required this.category4,
    required this.category5,
  });

  //insert getters and setters here
  int get getUserID => userID;
  String get getCategory1 => category1;
  String? get getCategory2 => category2;
  String? get getCategory3 => category3;
  String? get getCategory4 => category4;
  String? get getCategory5 => category5;

   factory Interest.fromArray(int userID, List<String> categories) {
    return Interest(
      userID: userID,
      category1: categories.length > 0 ? categories[0] : '',
      category2: categories.length > 1 ? categories[1] : null,
      category3: categories.length > 2 ? categories[2] : null,
      category4: categories.length > 3 ? categories[3] : null,
      category5: categories.length > 4 ? categories[4] : null,
    );
  }
}


//toString method
String interestToString(Interest interest) {
  return 'User ID: ${interest.getUserID}\nCategory 1: ${interest.getCategory1}\nCategory 2: ${interest.getCategory2}\nCategory 3: ${interest.getCategory3}\nCategory 4: ${interest.getCategory4}\nCategory 5: ${interest.getCategory5}';
}

