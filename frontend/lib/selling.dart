import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          onBackground: Color(0xFFFFFFFF),
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
  String? _category;
  String? _condition;
  String? _itemDetails;
  double? _price;
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


  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Add logic here to save the listing to your marketplace.
      // For this example, we'll print the input values.
      _formKey.currentState?.save();
      print('Category: $_category');
      print('Condition: $_condition');
      print('Item Details: $_itemDetails');
      print('Price: $_price');
    }
  }

  void _addDescription() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ItemDetailsPage(),
    )).then((value) {
      if (value != null) {
        setState(() {
          _itemDetails = value.description;
        });
      }
    });
  }

  void _addPrice() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PriceInputPage(),
    )).then((value) {
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
        title: Text('Marketplace'),
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
              SizedBox(height: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildImageSelectionButton(0),
                  _buildImageSelectionButton(1),
                  _buildImageSelectionButton(2),
                  _buildImageSelectionButton(3),
                ],
              ),
              // if (_imageFiles != null && _imageFiles!.isNotEmpty)
              //   Column(
              //     children: _imageFiles!
              //         .map((image) => Image.file(File(image.path)))
              //         .toList(),
              //   ),

              SizedBox(height: 16.0),

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey, // You can change the border color as needed
                  ),
                ),
                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Category'),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _category = value;
                  },
                ),
              ),

              SizedBox(height: 20), // Increased distance between "Category" and the left side

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

              SizedBox(height: 16.0),

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
                        decoration: InputDecoration(labelText: 'Item Details'),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        readOnly: true,
                        controller: TextEditingController(
                          text: _itemDetails ?? '',
                        ),
                        onTap: _addDescription,
                      ),
                    ),
                    TextButton(
                      onPressed: _addDescription,
                      style: TextButton.styleFrom(
                        primary: Color(0xFF5C795B), // Change the button text color
                        textStyle: TextStyle(fontWeight: FontWeight.bold), // Bold text
                      ),
                      child: Text('Add'),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

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

              SizedBox(height: 20),

              Container(
                width: double.infinity, // Make the button the same width as the price input
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blue, // Customize the button color as needed
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
            SizedBox(height: 16.0),
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
                primary: Color(0xFF5C795B), // Change the button color
              ),
              child: Text(
                'Save',
                style: TextStyle(fontWeight: FontWeight.bold), // Bold text
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

class PriceInputPage extends StatefulWidget {
  @override
  _PriceInputPageState createState() => _PriceInputPageState();
}

class _PriceInputPageState extends State<PriceInputPage> {
  TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Price'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              controller: _priceController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double? price = double.tryParse(_priceController.text);
                Navigator.of(context).pop(price); // Return the entered price to the previous page
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF5C795B), // Change the button color
              ),
              child: Text(
                'Save',
                style: TextStyle(fontWeight: FontWeight.bold), // Bold text
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
