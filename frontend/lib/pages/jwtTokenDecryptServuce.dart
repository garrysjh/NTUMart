import 'dart:html';

import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
class JwtTokenDecrypt {
  static Future<int?> getID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    
    if (token != null) {
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      int id = decodedToken["id"]; 
      return id; 
    } else {
      return null;
    }
  }
  static Future<int?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    
    if (token != null) {
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      int id = decodedToken["username"]; 
      return id; 
    } else {
      return null;
    }
  }
}


void main(){ 
  Map<String, dynamic> decodedToken = Jwt.parseJwt("eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJIZWxsbyIsImNyZWF0ZWQiOjE2OTg4MjU1NzM3ODksImlkIjoxLCJleHAiOjE3MzQ4MjU1NzN9.RvPdjkRof9cK8jSy6elUxaXzh9t7jHk5DY9-PbFECus");
  print(decodedToken); 
}