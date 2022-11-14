import 'package:flutter/material.dart';

class ChatItem {
  final String text;
  final bool isCurrentUser;

  ChatItem({required this.text, required this.isCurrentUser});
}

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatItem> chatList = [
    ChatItem(text: 'Hii', isCurrentUser: false),
    ChatItem(
        text: 'Hello',
        isCurrentUser: true),
    ChatItem(text: 'How are you?', isCurrentUser: false),
    ChatItem(
        text: 'I am good,you?', isCurrentUser: true),
    ChatItem(text: 'Fine', isCurrentUser: false),
    ChatItem(
        text: 'ok, lets go!', isCurrentUser: true),
    ChatItem(text: 'Where?', isCurrentUser: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const BackButton(),
          titleSpacing: 0,
          centerTitle: false,
          title: const Text('User A',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.white))),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (BuildContext context, int index) {
            final item = chatList[index];
            return getChatItemView(item: item);
          },
          itemCount: chatList.length,
          physics: const BouncingScrollPhysics(),
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