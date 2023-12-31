
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/custominterests.dart';
import 'package:frontend/theme.dart';
import 'package:frontend/widgets/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:frontend/pages/jwtTokenDecryptService.dart';
import 'package:frontend/main.dart';
import 'package:frontend/homepage.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController loginUsernameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  final FocusNode focusNodeEmail = FocusNode();
  final FocusNode focusNodePassword = FocusNode();

  bool _obscureTextPassword = true;

  @override
  void dispose() {
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SizedBox(
                  width: 300.0,
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodeEmail,
                          controller: loginUsernameController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: 'Username',
                            hintStyle: TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                          ),
                          onSubmitted: (_) {
                            focusNodePassword.requestFocus();
                          },
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: focusNodePassword,
                          controller: loginPasswordController,
                          obscureText: _obscureTextPassword,
                          style: const TextStyle(
                              fontFamily: 'WorkSansSemiBold',
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                                fontFamily: 'WorkSansSemiBold', fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextPassword
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          onSubmitted: (_) {
                            _toggleSignInButton();
                          },
                          textInputAction: TextInputAction.go,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 205.0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: CustomTheme.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: CustomTheme.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: LinearGradient(
                      colors: <Color>[
                        CustomTheme.loginGradientEnd,
                        CustomTheme.loginGradientStart
                      ],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: <double>[0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: CustomTheme.loginGradientEnd,
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontFamily: 'WorkSansBold'),
                    ),
                  ),
                  onPressed: () => {_toggleSignInButton()},
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: 'WorkSansMedium'),
                )),
          ),
        ],
      ),
    );
  }

  //userId == 1 for has interest
  //userId == 2 for doesnt have interest
  
  // move to customInterest if interest dont exist, 
  // move to home if interest exist

  void _toggleSignInButton() async {
    try {
          int? userId; 
          int authenticated = await loginUser(
          loginUsernameController.text, loginPasswordController.text);
          if (authenticated ==1){ 
            userId = await JwtTokenDecryptService.getID(); 
            print(userId);
          }
          int hasInterest = await checkInterest(userId);

      if (authenticated == 1 && hasInterest == 1) {
        CustomSnackBar(context, const Text('Sign-in successful'));
        await Future.delayed(const Duration(seconds: 1));
        moveToHome();
      } else if (authenticated == 1 && hasInterest == 0) {
        CustomSnackBar(context, const Text('Sign-in successful'));
        print('no interest');
        await Future.delayed(const Duration(seconds: 1));
        moveToInterest();
      }
      else if (authenticated == 0) {
        CustomSnackBar(context, const Text('Wrong email/password'));
      } else {
        CustomSnackBar(
            context,
            const Text(
                'Our servers are down at the moment. Please try again later. '));
      }
    } catch (e) {
      // Handle sign-in errors, e.g., wrong credentials.
      CustomSnackBar(context, Text('Sign-In Error: $e'));
    }
  }

  void moveToHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }

    void moveToInterest() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CustomInterests()));
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }
}


Future<int> checkInterest(int? id) async{
  final url = Uri.parse('$URL/$id/checkInterest');
  try{
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return 1;
    } else {
      // Request failed
      print('Failed to login. Status code: ${response.statusCode}');
      return 0;
    }
  } catch (e) {
    print('Error: $e');
    return 0;
  }
}

Future<int> loginUser(String username, String password) async {
  final url = Uri.parse('$URL/user/login'); // Replace with your server URL

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Request was successful
      final jsonResponse = json.decode(response.body);
      if (jsonResponse == "Username already exists!") {
        return 0;
      }
      final token = jsonResponse['token'];

      // Store the token in local storage (shared_preferences)
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      print('Login successful. Token: $token');
      return 1;
    } else {
      // Request failed
      print('Failed to login. Status code: ${response.statusCode}');
      return -1;
    }
  } catch (e) {
    print('Error: $e');
    return -1;
  }
}
