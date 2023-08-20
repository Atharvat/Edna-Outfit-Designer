import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;


Widget customMessageBuilder(types.CustomMessage message,
    Function onExpandPressed,
    {required int messageWidth}) {
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
          onPressed: onExpandPressed(),
          child: const Text('Expand'),
        ),
      ],
    ),
  );
}