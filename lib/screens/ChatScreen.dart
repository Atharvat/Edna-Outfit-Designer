import 'dart:convert';

import 'package:edna/globals/myFonts.dart';
import 'package:edna/globals/prompts.dart';
import 'package:edna/screens/BurgerMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';
import 'package:bubble/bubble.dart';
import 'package:http/http.dart' as http;

import '../globals/myColors.dart';
import '../utils/flipkart_api.dart';
import '../utils/server_api.dart';

class LookScreenArguments {
  final String pageTitle;
  final List<List<ProductDetails>> allProductDetails;

  LookScreenArguments(this.pageTitle, this.allProductDetails);
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: "Gunjan");
  final _ednauser = const types.User(id: "Edna");
  String pageTitle = "Chat with Edna";

  @override
  void initState() {
    super.initState();
    // _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _sendInitialPrompt(types.PartialText message) async {
    // first message. So send the initial prompt before the message to the API
    print("debug: Sending initial prompt to the API");
    final response = await sendTextToServer(Prompts.initialPrompt);

    if (response != null && response.containsKey('message')) {
      // Extract the message from the response
      final receivedMessage = response['message'] as String;
      print("debug: *****Received message from API: $receivedMessage.*****");
      print("debug: *****Initialisation of chat successfully completed*****" "");
    }

    // send a message from Edna's side to confirm the initial prompt has been sent
    final newMessage = types.TextMessage(
      author: _ednauser,
      id: const Uuid().v4(),
      text:
          "Hi, I'm Edna. I'm here to help you find the perfect outfit for your occasion. What are you looking for today?",
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    _addMessage(newMessage);
  }

  Map<String, dynamic> parseJson(String jsonString) {
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return jsonData;
  }

  void _lookMessageHandler(Map<String, dynamic>? response) async {
    print("debug: *****Received custom message.*****");
    print(response?['message']);

    // Parse the json from the message
    final jsonData = parseJson(response?['message']);

    if(jsonData.containsKey("Title")){
      setState(() {
        pageTitle = jsonData['Title'];
      });
    }

    // show the first two looks obtained from the API
    if(jsonData.containsKey('Look 1')){
      Map<String, dynamic>? look1 = jsonData['Look 1'];

      List<dynamic> items = look1?['items'];
      List<List<ProductDetails>> allProductDetails = [];

      // loop to iterate through items and call the flipkart api for each query
      for (int i = 0; i < items.length; i++) {
        print("debug: *****Calling flipkart api for item: ${items[i]}*****");
        String item = items[i];
        // call the flipkart api for the item
        List<ProductDetails>? productDetails = await flipkartSearch(look1?[item]);
        allProductDetails.add(productDetails!);
      }

      look1?['productDetails'] = allProductDetails;

      final look1Message = types.CustomMessage(
        author: _ednauser,
        id: const Uuid().v4(),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        metadata: look1,
      );
      _addMessage(look1Message);
      final look1Description = types.TextMessage(
        author: _ednauser,
        id: const Uuid().v4(),
        text: look1?['Explanation'],
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      _addMessage(look1Description);
    }

    if(jsonData.containsKey('Look 2')){
      Map<String, dynamic>? look2 = jsonData['Look 2'];
      List<dynamic> items = look2?['items'];
      List<List<ProductDetails>> allProductDetails = [];

      // loop to iterate through items and call the flipkart api for each query
      for (int i = 0; i < items.length; i++) {
        String item = items[i];
        // call the flipkart api for the item
        List<ProductDetails>? productDetails = await flipkartSearch(look2?[item]);
        allProductDetails.add(productDetails!);
      }

      look2?['productDetails'] = allProductDetails;
      final look2Message = types.CustomMessage(
        author: _ednauser,
        id: const Uuid().v4(),
        createdAt: DateTime.now().millisecondsSinceEpoch,
        metadata: look2,
      );
      _addMessage(look2Message);
      final look2Description = types.TextMessage(
        author: _ednauser,
        id: const Uuid().v4(),
        text: look2?['Explanation'],
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      _addMessage(look2Description);
    }
  }

  void _textMessageHandler(Map<String, dynamic>? response) async {
    final receivedMessage = response?['message'] as String;
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

  void _handleSendPressed(types.PartialText message) async {
    // Show current message on the UI
    final newMessage = types.TextMessage(
      author: _user,
      id: const Uuid().v4(),
      text: message.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    setState(() {
      _messages.insert(0, newMessage);
    });
    print("debug: *****Added current message: ${message.text} to list.*****");

    if (_messages.length == 1) {
      _sendInitialPrompt(message);
    }

    // Make a GET request to the API server to send the new message
    final response = await sendMessageToServer(newMessage);

    if (response != null && response.containsKey('message')) {
      // Extract the message from the response
      final receivedMessage = response['message'] as String;
      print("debug: *****Received message from API: $receivedMessage.*****");
      if (response.containsKey('looks')) {
        // Implies we have a custom looks message from Edna
        _lookMessageHandler(response);
      } else {
        // We have a text message from Edna
        _textMessageHandler(response);
      }
    } else {
      print("debug: Error: Could not send or receive message");
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
  }) =>
      Bubble(
        child: child,
        color:
            _user.id != message.author.id ? MyColors.white20 : MyColors.green20,
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
    print("debug: Expand pressed");
  }

  Widget _customMessageBuilder(types.CustomMessage message,
      {required int messageWidth}) {
    messageWidth = 15;
    // call the Flipkart API to get the images and other product info
    Map<String, dynamic>? look = message.metadata;
    List<dynamic> items = look?['items'];

    List<List<ProductDetails>> allProductDetails = look?['productDetails'];

    List<dynamic> imageUrls = [];
    for (int i = 0; i < allProductDetails.length; i++){
      List<ProductDetails>? productDetails = allProductDetails[i];
      if (productDetails != null) {
        imageUrls.add(productDetails[0].thumbnailUrl);
      }
    }

    if(imageUrls.length < 4){
      // fill the remaining slots with repeated images
      for(int i = 0; i < 4 - imageUrls.length; i++){
        imageUrls.add(imageUrls[0]);
      }
    } else {
      // take the first 4 images
      imageUrls = imageUrls.take(4).toList();
    }

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
              print("debug: *****Adding image: ${imageUrls[index]}*****");
              return Image.network(imageUrls[index]);
            },
          ),
          const SizedBox(height: 8.0),
          ElevatedButton(
            // call the LookScreen with the information from the
            onPressed: () {
              Navigator.pushNamed(context, '/look',
                  arguments: LookScreenArguments(pageTitle, allProductDetails));
            },
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
                    child: Text(
                      pageTitle,
                      style: const TextStyle(
                        fontFamily: 'Playfair Display',
                        fontSize: 24,
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
                      ) // add an image with 32 height
                      ),
                  tooltip: 'Profile',
                  onPressed: () {
                    // handle the press
                  },
                ),
              ]),
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
