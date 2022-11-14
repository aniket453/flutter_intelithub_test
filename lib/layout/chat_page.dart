import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_intelihub/helper/text_from_fields_helper.dart';
import 'package:flutter_intelihub/utils/app_string.dart';

class ChatItem {
  final String text;
  final bool isCurrentUser;

  ChatItem({required this.text, required this.isCurrentUser});
}

class ChatPage extends StatefulWidget {
  final String name;

  const ChatPage({required this.name, Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController chatController = TextEditingController();
  List<ChatItem> chatList = [
    ChatItem(text: 'How was the concert?', isCurrentUser: false),
    ChatItem(
        text: 'Awesome! Next time you gotta come as well!',
        isCurrentUser: true),
    ChatItem(text: 'Ok, when is the next date?', isCurrentUser: false),
    ChatItem(
        text: 'They\'re playing on the 20th of November', isCurrentUser: true),
    ChatItem(text: 'Let\'s do it!', isCurrentUser: false),
  ];

  void addChat({required ChatItem item}) {
    setState(() {
      chatList.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const BackButton(),
          titleSpacing: 0,
          centerTitle: false,
          title: Text(widget.name,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white))),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemBuilder: (BuildContext context, int index) {
                      final item = chatList[index];
                      return getChatItemView(item: item);
                    },
                    itemCount: chatList.length,
                    physics: const BouncingScrollPhysics())),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      onChanged: (val) {
                        setState(() {});
                      },
                      helperText: AppString.writeSomething,
                      controller: chatController,
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (chatController.text.trim().isNotEmpty) {
                          int num = Random().nextInt(10);

                          addChat(
                              item: ChatItem(
                                  text: chatController.text.trim(),
                                  isCurrentUser: num % 2 == 0));
                        }
                      },
                      child: chatController.text.isNotEmpty
                          ? const Icon(Icons.send,
                              size: 24, color: Colors.blueAccent)
                          : const Icon(Icons.send,
                              size: 24, color: Colors.grey))
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget getChatItemView({required ChatItem item}) {
    bool isCurrentUser = item.isCurrentUser;

    return Padding(
        padding: EdgeInsets.fromLTRB(
            isCurrentUser ? 64 : 16, 4, isCurrentUser ? 16 : 64, 4),
        child: Align(
            alignment:
                isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    color: isCurrentUser ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(item.text,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: isCurrentUser
                                ? Colors.white
                                : Colors.black87))))));
  }
}
