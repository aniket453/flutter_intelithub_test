import 'package:flutter/material.dart';
import 'package:flutter_intelihub/helper/custom_button.dart';
import 'package:flutter_intelihub/helper/text_from_fields_helper.dart';
import 'package:flutter_intelihub/layout/chat_page.dart';
import 'package:flutter_intelihub/layout/login_page.dart';
import 'package:flutter_intelihub/utils/app_color.dart';
import 'package:flutter_intelihub/utils/app_string.dart';
import 'package:flutter_intelihub/utils/app_utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedItem {
  final String name;
  final String userName;
  final bool isFavourite;

  FeedItem(
      {required this.name, this.isFavourite = false, required this.userName});
}

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  List<FeedItem> feedList = [
    FeedItem(name: 'Alita Angel', isFavourite: false, userName: 'rocking_star'),
    FeedItem(name: 'John Doe', isFavourite: true, userName: 'crippy'),
    FeedItem(name: 'Allien Fork', isFavourite: false, userName: 'funny_guy'),
    FeedItem(name: 'Kalpesh Patel', isFavourite: false, userName: 'jolly_d'),
    FeedItem(name: 'Jay Patel', isFavourite: true, userName: 'kp_001'),
    FeedItem(name: 'Luna Ro', isFavourite: true, userName: 'luna_r'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppString.feedPage),
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    addPostBottomSheet(),
                    isScrollControlled: true,
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  Get.offAll(const LoginPage());
                },
                child: const Icon(
                  Icons.logout_outlined,
                ),
              ),
            )
          ],
        ),
        body: SafeArea(
            child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12),
          physics: const BouncingScrollPhysics(),
          itemCount: feedList.length,
          itemBuilder: (BuildContext context, int index) {
            final item = feedList[index];
            return getPostView(item: item);
          },
        )));
  }

  Widget addPostBottomSheet() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Text(
              AppString.addFeed,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
                helperText: AppString.name,
                controller: nameController,
                validator: (val) {
                  if (val?.isEmpty ?? false) {
                    return AppString.firstNameFeildValidation;
                  } else if ((val?.length ?? 0) < 2) {
                    return AppString.firstNameLengthValidation;
                  }

                  return null;
                }),
            const SizedBox(height: 16),
            CustomTextFormField(
                helperText: AppString.userName,
                controller: userController,
                validator: (val) {
                  if (val?.isEmpty ?? false) {
                    return AppString.userNameFeildValidation;
                  } else if ((val?.length ?? 0) < 6) {
                    return AppString.userNameLengthValidation;
                  }

                  return null;
                }),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomButton(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    btnTag: AppString.cancel,
                    color: AppColor.red,
                  ),
                ),
                Expanded(
                  child: CustomButton(
                      onTap: () async {
                        FocusScope.of(context).unfocus();

                        if (nameController.text.trim().length >= 2 &&
                            userController.text.trim().length >= 6) {
                          feedList.add(FeedItem(
                              name: nameController.text.trim(),
                              userName: userController.text.trim()));
                          setState(() {});
                          Navigator.pop(context);
                        } else {
                          AppUtils.flutterShowToast(
                              msg: AppString.validateFields);
                        }
                      },
                      btnTag: AppString.save),
                ),
              ],
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget getPostView({required FeedItem item}) {
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
                    Text(item.name,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black)),
                    const SizedBox(height: 2),
                    Text(item.userName,
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
            children: [
              Icon(
                  item.isFavourite
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  size: 24,
                  color: item.isFavourite ? Colors.red : Colors.black),
              const SizedBox(width: 12),
              GestureDetector(
                  onTap: () {
                    Get.to(ChatPage(name: item.name));
                  },
                  child: const Icon(Icons.message_outlined,
                      size: 24, color: Colors.black)),
              const SizedBox(width: 12),
              const Icon(Icons.send, size: 24, color: Colors.black)
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
