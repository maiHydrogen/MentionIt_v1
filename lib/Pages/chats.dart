import 'package:mention_it/Components/chatusercard.dart';
import 'package:mention_it/api/api.dart';
import 'package:mention_it/models/chatuser.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

class MyChats extends StatefulWidget {
  const MyChats({super.key, required this.title, required this.controller});
  final String title;
  final MotionTabBarController controller;

  @override
  State<MyChats> createState() => MyChatsState();
}

class MyChatsState extends State<MyChats> {
  List<ChatUser> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            actions: [

              Center(
                child: Container(
                  decoration: BoxDecoration(
                    backgroundBlendMode: BlendMode.src,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(1, 1),
                      colors: <Color>[
                        Color(0x00000000),
                        Color.fromARGB(255, 21, 135, 152),
                      ], // Gradient from https://learnui.design/tools/gradient-generator.html
                      tileMode: TileMode.mirror,
                    ),
                    border: Border.all(color: Colors.black),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: const Row(
                    children: [
                      Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Search",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'kalam',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            SingleChildScrollView(
              child: Column(
                children: [
                  StreamBuilder(
                    stream: APIs.firestore.collection('users').snapshots(),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        //data is loading
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return const Center(
                              child: CircularProgressIndicator());
                        // if some or all data id loaded
                        case ConnectionState.active:
                        case ConnectionState.done:
                          final data = snapshot.data?.docs;
                          list = data
                                  ?.map((e) => ChatUser.fromJson(e.data()))
                                  .toList() ??
                              [];

                          if (list.isNotEmpty) {
                            return ListView.builder(
                              itemCount: list.length,
                              padding: EdgeInsetsDirectional.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.01),
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Chatusercard(user: list[index]);
                                //return Text('Name: ${list[index]}');
                              },
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.38,
                              ),
                              child: const Text('No Chats Found!',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.cyan)),
                            );
                          }
                      }
                    },
                  ),
                ],
              ),
            )
          ]))
        ],
      ),
    );
  }
}
