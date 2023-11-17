import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class JwtTokenDecryptService{
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

  static Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      Map<String, dynamic> decodedToken = Jwt.parseJwt(token);
      String username = decodedToken["sub"];
      print(username); 
      return username;
    } else {
      return null;
    }
  }

  static Future<bool> hasValidToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      if (JwtDecoder.isExpired(token)) {

        return false; // Token is expired
      }
       String? username= await getUsername(); 
      if (username != null) {
      print("username: $username");
    } else {
    print("No username available");
  }
      int? id = await getID(); 
      print ("id:$id");
      return true; // Token is valid
    } else {
      return false;
    }
  }
}

void main() {
  String testToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJIZWxsbyIsImNyZWF0ZWQiOjE2OTg4MjU1NzM3ODksImlkIjoxLCJleHAiOjE3MzQ4MjU1NzN9.RvPdjkRof9cK8jSy6elUxaXzh9t7jHk5DY9-PbFECus";

  try {
    Map<String, dynamic> decodedToken = Jwt.parseJwt(testToken);
    print(decodedToken);
  } catch (e) {
    print("Error decoding JWT: $e");
  }
}
