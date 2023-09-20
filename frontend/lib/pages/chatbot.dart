import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:dip/widgets/Messages.dart';


class ChatBot extends StatelessWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NTU Marketplace Chatbot',
      theme: ThemeData(brightness: Brightness.light),
      home: const ChatBotHome(),
    );
  }
}

class ChatBotHome extends StatefulWidget {
  const ChatBotHome({Key? key}) : super(key: key);

  @override
  _ChatBotHomeState createState() => _ChatBotHomeState();
}

class _ChatBotHomeState extends State<ChatBotHome> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5C795B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Add navigation logic as needed
          },
        ),
        centerTitle: true,
        title: const Text('NTU Marketplace Chatbot'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: MessagesScreen(messages: messages)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              color: const Color(0xFF5D7395),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                      )),
                  IconButton(
                      onPressed: () {
                        sendMessage(_controller.text);
                        _controller.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      )
                  )],
              ),
            )
          ],
        ),
      ),
    );
  }

  sendMessage(String text) async {
    if (text.isEmpty) {
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])), true);
      });

      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null) return;
      setState(() {
        addMessage(response.message!);
      });
    }
  }

  addMessage(Message message, [bool isUserMessage = false]) {
    messages.add({'message': message, 'isUserMessage': isUserMessage});
  }
}