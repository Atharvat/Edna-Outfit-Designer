import 'dart:convert';

import 'package:edna/globals/myFonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';
import 'package:bubble/bubble.dart';

import '../globals/myColors.dart';
import '../globals/myFonts.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: "gunjan");
  String pageTitle = "Goa Fashion Trip";

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

  void _handleSendPressed(types.PartialText message){
    final newMessage = types.TextMessage(
      author: _user,
      id: const Uuid().v4(),
      text: message.text,
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    _addMessage(newMessage);
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('messages.json');
    final messages = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(pageTitle, style: TextStyle(fontSize: 20)),
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

      ),
    );
  }
}
