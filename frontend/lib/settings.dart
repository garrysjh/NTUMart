import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/profile.dart';


class SettingsPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsPage(),
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF5C795B),
          onPrimary: Color(0xFFEAEAEA),
          secondary: Color(0xFF5D7395),
          onSecondary: Color(0xFFEAEAEA),
          error: Color(0xFFF32424),
          onError: Color(0xFFF32424),
          background: Color(0xFFF9F9F9),
          onBackground: Color(0xFFFFFFFF),
          surface: Color(0xFFEAEAEA),
          onSurface: Color(0xFF0C0C0C),
        ),
        useMaterial3: true,
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _interestsController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String _selectedGender = 'Male'; // Default gender
  List<String> _preferredPaymentMethods = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Keegan"),
              accountEmail: Text("@kiwigan"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/profile_image.jpg'), // Replace with your image
              ),
            ),
            _buildTextField("Username", _usernameController),
            _buildTextField("First Name", _firstNameController),
            _buildTextField("Last Name", _lastNameController),
            _buildTextField("Interests", _interestsController),
            _buildTextField("Phone Number", _phoneNumberController,
                keyboardType: TextInputType.phone),
            _buildTextField("Email", _emailController,
                keyboardType: TextInputType.emailAddress),
            _buildGenderDropdown(),
            SizedBox(height: 20),
            _buildPaymentMethodsCheckboxes(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
        ),
        Divider(),
      ],
    );
  }

  Widget _buildGenderDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gender'),
        DropdownButtonFormField<String>(
          value: _selectedGender,
          items: ['Male', 'Female', 'Other']
              .map((gender) => DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedGender = value!;
            });
          },
        ),
        Divider(),
      ],
    );
  }

  Widget _buildPaymentMethodsCheckboxes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Preferred Payment Methods'),
        CheckboxListTile(
          title: Text('Paynow'),
          value: _preferredPaymentMethods.contains('Paynow'),
          onChanged: (bool? value) {
            _updatePaymentMethods('Paynow', value ?? false);
          },
        ),
        CheckboxListTile(
          title: Text('PayLah!'),
          value: _preferredPaymentMethods.contains('PayLah!'),
          onChanged: (bool? value) {
            _updatePaymentMethods('PayLah!', value ?? false);
          },
        ),
        CheckboxListTile(
          title: Text('Cash'),
          value: _preferredPaymentMethods.contains('Cash'),
          onChanged: (bool? value) {
            _updatePaymentMethods('Cash', value ?? false);
          },
        ),
        CheckboxListTile(
          title: Text('Bank Transfer'),
          value: _preferredPaymentMethods.contains('Bank Transfer'),
          onChanged: (bool? value) {
            _updatePaymentMethods('Bank Transfer', value ?? false);
          },
        ),
        ElevatedButton(
          onPressed: () {
            logOut(context);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.white, // Change this color to the desired one
          ),
          child: Text('Log Out'),
        )
      ],
    );
  }

  void logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    print("LOGGING OUT");
    await navigateToLoginPage(context);
  }

  Future navigateToLoginPage(BuildContext context) async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  void _updatePaymentMethods(String method, bool selected) {
    setState(() {
      if (selected) {
        _preferredPaymentMethods.add(method);
      } else {
        _preferredPaymentMethods.remove(method);
      }
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _interestsController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}