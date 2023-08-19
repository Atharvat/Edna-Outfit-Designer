import 'dart:convert';

import 'package:edna/globals/myFonts.dart';
import 'package:edna/screens/BurgerMeny.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';
import 'package:bubble/bubble.dart';
import 'package:http/http.dart' as http;

import '../globals/myColors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: "Gunjan");
  final _ednauser = const types.User(id: "Edna");
  String pageTitle = "Goa fashion week";

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message){
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    final newMessage = types.TextMessage(
      author: _user,
      id: const Uuid().v4(),
      text: message.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    setState(() {
      _messages.insert(0, newMessage);
    });
    print("*****Added current message to list.*****");

    // Make a GET request to the API server to send the new message
    final response = await _sendMessageToServer(newMessage);

    if (response != null && response.containsKey('message')) {
      // Extract the message from the response
      final receivedMessage = response['message'] as String;
      print("*****Received message from API: ${receivedMessage}.*****");
      if(receivedMessage == "custom"){
        print("*****Received custom message.*****");
        print(response['metadata']);
        final customMessage = types.CustomMessage(
          author: _ednauser,
          id: const Uuid().v4(),
          createdAt: DateTime.now().millisecondsSinceEpoch,
          metadata: {
            "imageUrls": response['metadata'],
        },
        );
        _addMessage(customMessage);
      } else {
        // Create a new message object for the received message
        final receivedTextMessage = types.TextMessage(
          author: _ednauser, // Assuming the server is the author
          id: const Uuid().v4(),
          text: receivedMessage,
          createdAt: DateTime.now().millisecondsSinceEpoch,
        );

        // Add the received message to the UI
        _addMessage(receivedTextMessage);
      }


    } else {
      print('Error: Could not send or receive message');
    }
  }

  Future<Map<String, dynamic>?> _sendMessageToServer(types.TextMessage newMessage) async {
    final apiUrl = 'http://192.168.0.108:5000/?message=${newMessage.text}';
    final response = await http.get(Uri.parse(apiUrl));
    print("********Made request to the API.********");

    if (response.statusCode == 200) {
      // Successful response, parse the JSON and return it
      return Map<String, dynamic>.from(json.decode(response.body));
    } else {
      // Handle errors here
      return null;
    }
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();
    print(messages.length);
    setState(() {
      _messages = messages;
    });
  }

  Widget _bubbleBuilder(
      Widget child, {
    required message,
    required nextMessageInGroup,
  }) => Bubble(
    child: child,
    color: _user.id != message.author.id ?
    MyColors.white20 : MyColors.green20,
    padding: const BubbleEdges.only(right: 2, left: 2),
    margin: nextMessageInGroup
        ? const BubbleEdges.symmetric(horizontal: 8)
        : null,
    nip: nextMessageInGroup
        ? BubbleNip.no
        : _user.id != message.author.id
        ? BubbleNip.leftBottom
        : BubbleNip.rightBottom,
  );

  void onExpandPressed() {
    print("Expand pressed");
  }

  Widget _customMessageBuilder(types.CustomMessage message, {required int messageWidth}) {
    messageWidth = 15;
    List<dynamic> imageUrls = message.metadata?['imageUrls'];
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return Image.network(imageUrls[index]);
            },
          ),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: onExpandPressed,
            child: const Text('Expand'),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BurgerMenu(),
      appBar: AppBar(
        primary: true,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(pageTitle,
                    style: const TextStyle(
                      fontFamily: 'Playfair Display',
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              IconButton(
                //add an image with rounded corners as an icon
                icon: ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: const Image(
                      image: AssetImage('images/gunjan.jpeg'),
                      height: 32,
                      width: 32,
                    )// add an image with 32 height
                ),
                tooltip: 'Profile',
                onPressed: () {
                  // handle the press
                },
              ),
            ]
          ),
        ),
      ),
      body: Chat(
        theme: const DefaultChatTheme(
          sentMessageBodyTextStyle: MyFonts.sentMessageStyle,
          receivedMessageBodyTextStyle: MyFonts.receivedMessageStyle,
          userNameTextStyle: MyFonts.senderNameStyle,
        ),
        bubbleBuilder: _bubbleBuilder,
        messages: _messages,
        onSendPressed: _handleSendPressed,
        showUserAvatars: false,
        showUserNames: false,
        user: _user,
        customMessageBuilder: _customMessageBuilder,
      ),
    );
  }
}
