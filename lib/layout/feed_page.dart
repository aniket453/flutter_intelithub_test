import 'package:flutter/material.dart';
import 'package:flutter_intelihub/layout/chat_page.dart';
import 'package:flutter_intelihub/utils/app_string.dart';
import 'package:get/get.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppString.feedPage),
          automaticallyImplyLeading: false,
          actions: [
            GestureDetector(
              onTap: () {
                Get.to(const ChatPage());
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Icons.chat_outlined),
              ),
            )
          ],
        ),
        body: SafeArea(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 12),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return getPostView();
                },
                itemCount: 8)));
  }

  Widget getPostView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network('https://picsum.photos/200/300',
                      fit: BoxFit.cover, height: 40, width: 40)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('User A',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    const SizedBox(height: 2),
                    Text('rocking_star',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.8))),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Image.network('https://picsum.photos/seed/picsum/200/300',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: const [
              Icon(Icons.favorite_border_outlined,
                  size: 24, color: Colors.black),
              SizedBox(width: 12),
              Icon(Icons.message_outlined, size: 24, color: Colors.black),
              SizedBox(width: 12),
              Icon(Icons.send, size: 24, color: Colors.black)
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
