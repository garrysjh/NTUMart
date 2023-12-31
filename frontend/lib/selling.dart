import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/homepage.dart';
import 'package:frontend/pages/jwtTokenDecryptService.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() {
  runApp(Sell());
}

class Sell extends StatelessWidget {
  const Sell({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CreateListingPage(),
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
          onBackground: Color(0xFF5C795B),
          surface: Color(0xFFEAEAEA),
          onSurface: Color(0xFF5C795B),
        ),
        useMaterial3: true,
      ),
    );
  }
}

class CreateListingPage extends StatefulWidget {
  @override
  _CreateListingPageState createState() => _CreateListingPageState();
}

class _CreateListingPageState extends State<CreateListingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List ConditionType = [
    "Brand New",
    "Like New",
    "Lightly Used",
    "Well Used",
    "Heavily Used"
  ];
  List categories = [
    "Men's Fashion",
    "Women's Fashion",
    "Footwear",
    "Books & Notes",
    "Furniture",
    "Home Decor",
    "Food Items",
    "Electronics",
    "Mobile Gadgets",
    "Services",
    "Personal care",
    "Health & Nutrition"
  ];
  String? valueChoose;
  String? _category;
  String? _condition;
  String? _itemDetails;
  double? _price;
  String? _title;
  List<XFile>? _imageFiles = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile>? selectedImages = await _picker.pickMultiImage();

    if (selectedImages != null && selectedImages.isNotEmpty) {
      setState(() {
        _imageFiles = selectedImages;
      });
    }
  }

  Widget _buildImageSelectionButton(int index) {
    return InkWell(
      onTap: () {
        // Add logic to select an image when the square button is tapped.
        // You can use _pickImages or any other image selection method.
        _pickImages();
      },
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: _imageFiles != null &&
                  _imageFiles!.isNotEmpty &&
                  index < _imageFiles!.length
              ? Image.file(
                  File(_imageFiles![index].path),
                  width: 70.0,
                  height: 70.0,
                  fit: BoxFit.cover,
                )
              : Icon(
                  Icons.add,
                  size: 40.0,
                  color: Colors.grey,
                ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Add logic here to save the listing to your marketplace.
      // For this example, we'll print the input values.
      _formKey.currentState?.save();
      print('Category: $_category');
      print('Condition: $_condition');
      print('Item Details: $_itemDetails');
      print('Price: $_price');
      print('Name: $_title');
      // Create a MultipartRequest
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$URL/product/add'), // Replace with your actual backend URL
      );

      // Add form fields
      int? sellerID = await JwtTokenDecryptService.getID();
      request.fields["sellerID"] = sellerID.toString() ?? "0";
      request.fields['category'] = _category!;
      request.fields['condition'] = _condition!;
      request.fields['description'] = _itemDetails!;
      request.fields['price'] = _price.toString();
      request.fields['quantity'] = '1';
      request.fields['name'] = _title!;

      // Add image files
      for (int i = 0; i < _imageFiles!.length; i++) {
        var fieldName = i == 0 ? 'productPicture' : 'productPicture${i + 1}';
        var file = await http.MultipartFile.fromPath(
          fieldName,
          _imageFiles![i].path,
        );
        request.files.add(file);
        print(request);
      }
      try {
        var response = await request.send();
        if (response.statusCode == 200) {
          print('Product successfully added');

          final capturedContext = context;

          await Navigator.push(
            capturedContext,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return Home();
              },
            ),
          );
        } else {
          print('Error adding product. Status code: ${response.statusCode}');
        }
      } catch (error) {
        print('Error sending request: $error');
      }
    }
  }

  void _addDescription() {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => ItemDetailsPage(),
    ))
        .then((value) {
      if (value != null) {
        _formKey.currentState?.save();
        print("HERE!");
        print(value);
        print(value['description']);
        setState(() {
          _title = value['title'];
          _itemDetails = value['description'];
        });
      }
    });
  }

  void _addPrice() {
    Navigator.of(context)
        .push(MaterialPageRoute(
      builder: (context) => PriceInputPage(),
    ))
        .then((value) {
      if (value != null) {
        setState(() {
          _price = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF5C795B),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const Home();
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.easeInOut;
                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Add Details',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 16.0),

              Text(
                'Photo',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildImageSelectionButton(0),
                  _buildImageSelectionButton(1),
                  _buildImageSelectionButton(2),
                  _buildImageSelectionButton(3),
                ],
              ),
              SizedBox(
                  height: 35.0,
              ),

                 DropdownButtonFormField(
                  decoration:InputDecoration(
                    labelText: "Categories",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                  ),
                  //dropdownColor: Colors.white10,
                  borderRadius: BorderRadius.circular(10.0),
                  icon: Icon(Icons.arrow_drop_down, color: Color(0xFF5C795B)),
                  iconSize: 36,
                  isExpanded: true,
                  //underline: SizedBox(),
                  value: _category,
                  validator: (value) => value == null ? 'field required' : null,
                  onChanged: (newValue) {
                    setState(() {
                      _category = newValue.toString();
                    });
                  },
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                ),

              SizedBox(
                  height:
                      20), // Increased distance between "Category" and the left side

              /*Original Price
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey, // You can change the border color as needed
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 16.0), // Increased distance between "Price" and the left side
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Price'),
                        keyboardType: TextInputType.number,
                        readOnly: true,
                        controller: TextEditingController(
                          text: _price != null ? _price.toString() : '',
                        ),
                        onTap: _addPrice,
                      ),
                    ),
                    TextButton(
                      onPressed: _addPrice,
                      style: TextButton.styleFrom(
                        primary: Color(0xFF5C795B), // Change the button text color
                        textStyle: TextStyle(fontWeight: FontWeight.bold), // Bold text
                      ),
                      child: Text('Add'),
                    ),
                  ],
                ),
              ),


            */

              DropdownButtonFormField(
                decoration:InputDecoration(
                  labelText: "Condition",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                ),

                //dropdownColor: Colors.white10,
                borderRadius: BorderRadius.circular(10.0),
                icon: Icon(Icons.arrow_drop_down, color: Color(0xFF5C795B)),
                iconSize: 36,
                isExpanded: true,
                value: _condition,
                validator: (value) => value == null ? 'field required' : null,
                onChanged: (newValue) {
                  setState(() {
                    _condition = newValue.toString();
                  });
                },
                items: ConditionType.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),

              SizedBox(height: 16.0),
              /*
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey, // You can change the border color as needed
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 16.0), // Increased distance between "Condition" and the left side
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Condition'),
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter the condition';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _condition = value;
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Add logic here to change the condition
                      },
                      style: TextButton.styleFrom(
                        primary: Color(0xFF5C795B), // Change the button text color
                        textStyle: TextStyle(fontWeight: FontWeight.bold), // Bold text
                      ),
                      child: Text('Add'),
                    ),
                  ],
                ),
              ),
              */
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Price",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a price';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.tryParse(value ?? '');
                },
              ),


              SizedBox(height: 20),
              //Alternative implementation of button. Although shouldnt use textformfield altogether
              /*
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Item Details',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  suffixIcon: Icon(Icons.add),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                readOnly: true,

                controller: TextEditingController(
                  text: _itemDetails ?? '',
                ),
                onTap: _addDescription,
              ),*/
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color(
                        0xFF5C795B), // You can change the border color as needed
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                        width:
                            16.0), // Increased distance between "Condition" and the left side
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            labelText: 'Item Details',
                            //floatingLabelBehavior: FloatingLabelBehavior.never, //to remove default animation, however hinttext will disappear
                            border: InputBorder.none
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        readOnly: true,
                        controller: TextEditingController(
                          text: _itemDetails ?? '',
                        ),
                        onTap: _addDescription,
                        validator: (value) {
                          if (_itemDetails?.isEmpty ?? true) {

                          }
                          return null;
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: _addDescription,
                      style: TextButton.styleFrom(
                        primary:
                            Color(0xFF5C795B), // Change the button text color
                        textStyle:
                            TextStyle(fontWeight: FontWeight.bold), // Bold text
                      ),
                      child: Text('Add'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
 // Increased distance between "Condition" and the left side


              Container(
                width: double
                    .infinity, // Make the button the same width as the price input
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFF5D7395), // Customize the button color as needed
                ),
                child: TextButton(
                  onPressed: _submitForm,
                  child: Text(
                    'List It!',
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemDetailsPage extends StatefulWidget {
  @override
  _ItemDetailsPageState createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _brandController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  bool _hasMultipleItems = false;
  bool _delivery = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Item Details',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Listing Title*'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a listing title';
                }
                return null;
              },
              controller: _titleController,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Brand'),
              controller: _brandController,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _descriptionController,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Checkbox(
                  value: _hasMultipleItems,
                  onChanged: (value) {
                    setState(() {
                      _hasMultipleItems = value ?? false;
                    });
                  },
                ),
                Text('I have more than one of this item'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _delivery,
                  onChanged: (value) {
                    setState(() {
                      _delivery = value ?? false;
                    });
                  },
                ),
                const Text('I want to pay \$3 more for delivery   '),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _showDialog(context);
                    },
                    child: Text('?', style: TextStyle(fontSize: 20.0)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String title = _titleController.text;
                String brand = _brandController.text;
                String description = _descriptionController.text;
                Navigator.of(context).pop({
                  'title': title,
                  'brand': brand,
                  'description': description,
                  'hasMultipleItems': _hasMultipleItems,
                });
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF5D7395), // Change the button color
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white), // Bold text
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _brandController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Delivery Services',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
            'We offer delivery services in NTU, which are pay on delivery. If you check this option, we will contact you when your item is sold to arrange a delivery date!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}

class PriceInputPage extends StatefulWidget {
  @override
  _PriceInputPageState createState() => _PriceInputPageState();
}

class _PriceInputPageState extends State<PriceInputPage> {
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Price'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              controller: _priceController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double? price = double.tryParse(_priceController.text);
                Navigator.of(context).pop(
                    price); // Return the entered price to the previous page
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xFF5C795B), // Change the button color
              ),
              child: const Text(
                'Save',
                style:  TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white), // Bold text
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }
}
