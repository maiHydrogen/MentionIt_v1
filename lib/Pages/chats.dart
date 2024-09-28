import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';

class MyChats extends StatefulWidget {
  const MyChats({super.key, required this.title, required this.controller});
  final String title;
  final MotionTabBarController controller;

  @override
  State<MyChats> createState() => __MyChatsState();
}

class __MyChatsState extends State<MyChats> {
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
              Container(
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
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.search,
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

            ],
          )
        ],
      ),
    );
  }
}
