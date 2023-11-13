import 'package:flutter/material.dart';

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
  String hallRoom = 'No Hall';
  String roomNo = 'Room Not Chosen';
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Align(alignment: Alignment.center, child: Column(
          children: [
            Text(hallRoom),
            Text(roomNo),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF5C795B),
                ),
              onPressed: () {
                _showDialog();
              },
              child: Text('Edit Hall Room'),
            ),
          ],
        ),
      ),
    ));
  }

  _showDialog() async {
    String result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Padding(padding: EdgeInsets.only(top:20), child: Text('Which hall do you stay in?', style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w800,
                                      color: Color(0xFF5C795B),),),),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [Text('Enter your hall and hall room number to be matched with fellow roomies (incoming and outgoing)!'), Padding(padding: EdgeInsets.only(top:10), child: Align(alignment: Alignment.centerLeft, child: Text('Leave as NA if no hall is chosen'))),
                  Padding(padding: EdgeInsets.only(top:20), child: Align(alignment: Alignment.centerLeft, child: DropdownButton<String>(
                    value: hallRoom,
                    items: ['No Hall', 'Hall 1', 'Hall 2', 'Hall 3', 'Hall 4', 'Hall 5', 'Hall 6', 'Hall 7', 'Hall 8', 'Hall 9', 'Hall 10', 'Hall 11', 'Hall 12', 'Hall 13,', 'Hall 14', 'Hall 15', 'Hall 16', 'Crescent Hall', 'Pioneer Hall', 'Binjai Hall', 'Tanjong Hall', 'Banyan Hall', 'Saraca Hall', 'Tamarind Hall']
                        .map((String value) {
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
                  SizedBox(height: 10),
                  TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      labelText: 'Enter your hall room number',
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close', style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                      color: Color(0xFF5C795B),),),
                ),
                TextButton(
                  onPressed: () {
                    // Perform actions when the user clicks on the "Submit" button
                    print('Dropdown Value: $hallRoom');
                    print('Text Field Value: ${textEditingController.text}');

                    // Close the dialog
                    Navigator.of(context).pop(hallRoom);
                  },
                  child: Text('Submit', style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                      color: Color(0xFF5C795B),),)),
                
              ],
            );
          },
        );
      },
    );

    // Update the Text widget with the selected value
    setState(() {
      hallRoom =  hallRoom;
      roomNo = textEditingController.text;
    });
  }
}