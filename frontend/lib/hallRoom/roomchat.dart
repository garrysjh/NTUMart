import 'package:flutter/material.dart';
import 'package:frontend/pages/widgets/taskbar.dart';
import 'package:frontend/hallRoom/hallStories.dart';
import 'package:frontend/hallRoom/floorStories.dart';
import 'package:frontend/widgets/snackbar.dart';

void main() {
  runApp(const RoomChat());
}

class RoomChat extends StatelessWidget {
  const RoomChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'RoomChat',
      home: RoomChatPage(),
    );
  }
}

class RoomChatPage extends StatefulWidget {
  const RoomChatPage({Key? key}) : super(key: key);

  @override
  State<RoomChatPage> createState() => _RoomChatPageState();
}

class _RoomChatPageState extends State<RoomChatPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDialog();
      dialogShown = true;

    });
  }

  Future<String?> addPost({
    required BuildContext context,
    required WidgetBuilder builder,
  }) async {
    return await showDialog(
      context: context,
      builder: builder,
    );
  }

  bool dialogShown = false;
  bool submitted = false; 
  String hallRoom = 'No Hall';
  String roomNo = 'NA';
  var posts = {
    'John': 'Hello Roomie!',
    'Jack': 'Selling my old table, anyone interested? @jack123',
  };
  TextEditingController textEditingController = TextEditingController();
  TextEditingController postController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    if (submitted){ 
      return Scaffold(
        bottomNavigationBar: Taskbar(),
        key: _scaffoldKey,
        body: Padding(
            padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
            child: Stack(children: <Widget>[
              Column(children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Stories from $hallRoom",
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF5C795B)))),
                const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                        'Tap to find out what is happening in your hall, or who is moving out!',
                        style: TextStyle(fontSize: 16))),
                Row(
                  children: <Widget>[
                    Column(children: [
                      Container(
                        padding: const EdgeInsets.all(4), // Border width
                        decoration: const BoxDecoration(
                          color: Color(0xFF5C795B),
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => const Hall()),
                                );
                              },
                              borderRadius: BorderRadius.circular(40),
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(40), // Image radius
                                child: Image.asset('assets/img/hall13.png',
                                    fit: BoxFit.cover),
                              )),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(hallRoom,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF5C795B))))
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(children: [
                        Container(
                          padding: const EdgeInsets.all(4), // Border width
                          decoration: const BoxDecoration(
                            color: Color(0xFF5C795B),
                            shape: BoxShape.circle,
                          ),
                          child: ClipOval(
                            child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => const Level()),
                                  );
                                },
                                borderRadius: BorderRadius.circular(40),
                                child: SizedBox.fromSize(
                                  size:
                                      const Size.fromRadius(40), // Image radius
                                  child: Image.asset('assets/img/level2.png',
                                      fit: BoxFit.cover),
                                )),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text('Level ${roomNo.substring(0, 2)}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF5C795B))))
                      ]),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Level $roomNo Message Board',
                            style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF5C795B))))),
                const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    child: Text(
                        'Tap to leave a message for your room, find out who is moving in, or offer to sell an item directly to your future roomie! Messages will disappear in a week.',
                        style: TextStyle(fontSize: 16))),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        for (var i in posts.keys)
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(children: <Widget>[
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20, top: 5),
                                        child: Text(i,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16
                                                // Add other text styling as needed
                                                )),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: SizedBox(
                                          child: Text(
                                              posts[i] ?? 'Post was empty')))
                                ]),
                              ))
                      ]),
                )
              ]),
              const Spacer(),
              Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5C795B),
                          ),
                          onPressed: () {
                            _addPost();
                          },
                          child: const Text('Add Post'),
                        )),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            _showDialog();
                          },
                          child: const Text('Edit Hall/Room'),
                        )),
                  ],
                ),
              ),
            ])));
      } else { 
        return Scaffold(backgroundColor: Color(0xFF5C795B)); 
      }
    }
    

  _addPost() async {
    String? result = await addPost(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('Add Post'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: postController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your post',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Perform actions when the user clicks on the "Submit" button
                  if (postController.text.isNotEmpty) {
                    // Perform actions when the user clicks on the "Submit" button
                    setState(() {
                      posts['You'] = postController.text;
                    });

                    // Close the dialog
                    Navigator.of(context).pop();
                  } else {
                    // Show an error message or handle it as needed
                    // For now, just print an error message
                    CustomSnackBar(
                        context, const Text('Field cannot be empty!'));
                  }

                  // Close the dialog
                },
                child: const Text('Submit'),
              ),
            ],
          );
        });
      },
    );

    setState(() {
      if (result != null) {
        posts['You'] = result;
      }
    });
  }

  _showDialog() async {
    String result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Which hall do you stay in?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF5C795B),
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                      'Enter your hall and hall room number to be matched with fellow roomies (incoming and outgoing)!'),
                  const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Leave as NA if no hall is chosen'))),
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: DropdownButton<String>(
                            value: hallRoom,
                            items: [
                              'No Hall',
                              'Hall 1',
                              'Hall 2',
                              'Hall 3',
                              'Hall 4',
                              'Hall 5',
                              'Hall 6',
                              'Hall 7',
                              'Hall 8',
                              'Hall 9',
                              'Hall 10',
                              'Hall 11',
                              'Hall 12',
                              'Hall 13,',
                              'Hall 14',
                              'Hall 15',
                              'Hall 16',
                              'Crescent Hall',
                              'Pioneer Hall',
                              'Binjai Hall',
                              'Tanjong Hall',
                              'Banyan Hall',
                              'Saraca Hall',
                              'Tamarind Hall'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                hallRoom = value!;
                              });
                            },
                          ))),
                  const SizedBox(height: 10),
                  TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      labelText: 'Enter your hall room number',
                    ),
                  ),
                ],
              ),
              actions: [
                // TextButton(
                //   onPressed: () {
                //     Navigator.of(context).pop();
                //   },
                //   child: const Text('Close', style: TextStyle(
                //                           fontSize: 18,
                //                           fontWeight: FontWeight.w800,
                //                       color: Color(0xFF5C795B),),),
                // ),
                TextButton(
                    onPressed: () {
                      if (textEditingController.text.isNotEmpty) {
                        // Perform actions when the user clicks on the "Submit" button
                        print('Dropdown Value: $hallRoom');
                        print(
                            'Text Field Value: ${textEditingController.text}');

                        // Close the dialog
                        Navigator.of(context).pop(hallRoom);
                        submitted = true; 
                      } else {
                        // Show an error message or handle it as needed
                        // For now, just print an error message
                        CustomSnackBar(
                            context, const Text('Field cannot be empty!'));
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF5C795B),
                      ),
                    )),
              ],
            );
          },
        );
      },
    );

    // Update the Text widget with the selected value
    setState(() {
      hallRoom = hallRoom;
      roomNo = textEditingController.text;
    });
  }
}
