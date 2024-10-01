import 'package:baatcheet/Pages/calls.dart';
import 'package:baatcheet/Pages/chats.dart';
import 'package:baatcheet/Pages/newchats.dart';
import 'package:baatcheet/Pages/settings.dart';
import 'package:baatcheet/api/api.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:baatcheet/Pages/sign_in.dart';
import 'package:baatcheet/Pages/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with TickerProviderStateMixin {
  void sidebar() {}
  // TabController _tabController;
  MotionTabBarController? _motionTabBarController;
  void goToNome() {}
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment(0.8, 1),
          colors: <Color>[
            Color(0x00000000),
            Color.fromARGB(255, 21, 135, 152),
            Color(0x001D1639),
          ], // Gradient from https://learnui.design/tools/gradient-generator.html
          tileMode: TileMode.mirror,
        ),
      ),
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 52,
          title: const Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'Chats',
            ),
          ),
          titleTextStyle: const TextStyle(
            fontFamily: 'kalam',
            fontSize: 26,
            fontWeight: FontWeight.w500,
            color: Colors.cyanAccent,
          ),
          leading: IconButton(
            onPressed: () {
              // if (!Platform.isAndroid && !Platform.isIOS) {
              //   _controller.setExtended(true);
              // }
              _key.currentState?.openDrawer();
            },
            icon: const Icon(
              FontAwesomeIcons.bars,
              color: Colors.cyanAccent,
              size: 30,
            ),
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                    color: Colors.cyanAccent, style: BorderStyle.solid),
              ),
              child: IconButton(
                onPressed: () => _key.currentState?.openEndDrawer(),
                icon: const Icon(
                  FontAwesomeIcons.bell,
                  color: Colors.cyanAccent,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        drawer: SidebarX(
          theme: const SidebarXTheme(
              decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.src,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: <Color>[
                    Color(0x00000000),
                    Color.fromARGB(255, 21, 135, 152),
                    Color(0x001D1639),
                  ], // Gradient from https://learnui.design/tools/gradient-generator.html
                  tileMode: TileMode.mirror,
                ),
              ),
              width: 200,
              textStyle: TextStyle(
                fontFamily: 'kalam',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.cyanAccent,
              ),
              iconTheme: IconThemeData(color: Colors.cyanAccent),
              itemTextPadding: EdgeInsets.only(left: 10, top: 8),
              selectedIconTheme: IconThemeData(color: Colors.white),
              selectedTextStyle: TextStyle(
                fontFamily: 'kalam',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              selectedItemTextPadding: EdgeInsets.only(left: 10, top: 8),
              hoverIconTheme: IconThemeData(color: Colors.white),
              hoverTextStyle: TextStyle(
                fontFamily: 'kalam',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              hoverColor: Colors.black),
          controller: SidebarXController(selectedIndex: 0, extended: true),
          items: const [
            SidebarXItem(
              icon: FontAwesomeIcons.user,
              label: 'My Account',
            ),
          ],
          footerItems: [
            SidebarXItem(
              icon: FontAwesomeIcons.arrowRightFromBracket,
              label: 'logout',
              onTap: () async {
                var shacyanPref = await SharedPreferences.getInstance();
                shacyanPref.setBool(WelcomepageState.keylogin, false);
                await APIs.auth.signOut();
                await GoogleSignIn().signOut();
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignIn(),
                  ),
                );
              },
            ),
          ],
        ),
        endDrawer: SidebarX(
          theme: const SidebarXTheme(
              decoration: BoxDecoration(
                backgroundBlendMode: BlendMode.src,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: <Color>[
                    Color(0x00000000),
                    Color.fromARGB(255, 21, 135, 152),
                    Color(0x001D1639),
                  ], // Gradient from https://learnui.design/tools/gradient-generator.html
                  tileMode: TileMode.mirror,
                ),
              ),
              width: 200,
              textStyle: TextStyle(
                fontFamily: 'kalam',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.cyanAccent,
              ),
              iconTheme: IconThemeData(color: Colors.cyanAccent),
              itemTextPadding: EdgeInsets.only(left: 10, top: 8),
              selectedIconTheme: IconThemeData(color: Colors.white),
              selectedTextStyle: TextStyle(
                fontFamily: 'kalam',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              selectedItemTextPadding: EdgeInsets.only(left: 10, top: 8),
              hoverIconTheme: IconThemeData(color: Colors.white),
              hoverTextStyle: TextStyle(
                fontFamily: 'kalam',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              hoverColor: Colors.black),
          controller: SidebarXController(selectedIndex: 0, extended: true),
          items: const [
            SidebarXItem(
              icon: FontAwesomeIcons.bell,
              label: 'Notifcations',
            ),
          ],
          footerItems: [
            SidebarXItem(
                icon: FontAwesomeIcons.solidTrashCan,
                label: 'Clear All',
                onTap: () => goToNome()),
          ],
        ),
        bottomNavigationBar: MotionTabBar(
          controller: _motionTabBarController,
          initialSelectedTab: "Chats",
          useSafeArea: true,
          labels: const ["Chats", "New Chat", "Calls", "Settings"],
          icons: const [
            FontAwesomeIcons.message,
            FontAwesomeIcons.penToSquare,
            FontAwesomeIcons.phone,
            FontAwesomeIcons.gear
          ],
          textStyle: const TextStyle(
            color: Colors.cyan,
          ),
          tabSize: 40,
          tabBarHeight: 50,
          tabIconColor: Colors.cyan,
          tabIconSize: 30,
          tabIconSelectedSize: 25.0,
          tabSelectedColor: Colors.cyan,
          tabIconSelectedColor: Colors.white,
          tabBarColor: Colors.transparent,
          onTabItemSelected: (int value) {
            setState(() {
              _motionTabBarController!.index = value;
            });
          },
        ),
        body: SafeArea(
          child: TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: _motionTabBarController,
            children: <Widget>[
              MyChats(title: "Chats", controller: _motionTabBarController!),
              MyNewChats(
                  title: "NewChats", controller: _motionTabBarController!),
              MyCalls(title: "Calls", controller: _motionTabBarController!),
              MySettings(
                  title: "Settings", controller: _motionTabBarController!),
            ],
          ),
        ),
      ),
    );
  }
}
