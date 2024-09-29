// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:baatcheet/Components/dialogs.dart';
import 'package:baatcheet/Pages/homepage.dart';
import 'package:baatcheet/Pages/welcome.dart';
import 'package:baatcheet/Components/square_tiles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => SignInState();
}

class SignInState extends State<SignIn> {
  final username = TextEditingController();
  final password = TextEditingController();
  static const String usernameKey = 'Username';
  static const String passwordKey = 'Password';
  void goToHome() {}
  _googleButton() {
    Dialogs.loading(context);
    _signInWithGoogle().then(
      (user) {
        Navigator.pop(context);
        
        if (user != null) {
          log('\nUser: ${user.user}');
          log('\n   UserAdditionalInfo: ${user.additionalUserInfo}');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHome(),
            ),
          );
        }
        ;
      },
    );
  }

  _githubButton() {
    _signInWithGitHub().then(
      (user) {
        log('\nUser: ${user.user}');
        log('\nUserAdditionalInfo: ${user.additionalUserInfo}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHome(),
          ),
        );
      },
    );
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      Dialogs.showSnackBar(context, 'Oops! looks like you\'re offline');
      return null;
    }
  }

  Future<UserCredential> _signInWithGitHub() async {
    // Create a new provider
    GithubAuthProvider githubProvider = GithubAuthProvider();

    return await FirebaseAuth.instance.signInWithProvider(githubProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment(0.8, 1),
          colors: <Color>[
            Color(0x00000000),
            Color.fromARGB(255, 21, 135, 152),
            Color(0x001D1639),
          ], // Gradient from https://learnui.design/tools/gradient-generator.html
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(height: 20),
                  const Icon(
                    Icons.lock_person,
                    size: 80,
                    color: Color.fromARGB(255, 225, 225, 230),
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Welcome!',
                    style: TextStyle(
                        fontFamily: 'kalam',
                        fontSize: 18,
                        color: Color.fromARGB(255, 226, 226, 230)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Let\'s get started by signing in first.',
                    style: TextStyle(
                        fontFamily: 'kalam',
                        fontSize: 18,
                        color: Color.fromARGB(255, 230, 233, 236)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 150,
                    width: 350,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                            controller: username,
                            hintText: 'Username or Email',
                            obscureText: false),
                        const SizedBox(
                          height: 10,
                        ),
                        MyTextField(
                            controller: password,
                            hintText: 'Password',
                            obscureText: true),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 25, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => goToHome(),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'kalam',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  NeumorphicButton(
                    onPressed: () async {
                      var sharedPref = await SharedPreferences.getInstance();
                      sharedPref.setBool(WelcomepageState.keylogin, true);
                      var pref = await SharedPreferences.getInstance();
                      pref.setString(usernameKey, username.text.toString());
                      pref.setString(passwordKey, password.text.toString());

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyHome(),
                        ),
                      );
                    },
                    style: const NeumorphicStyle(
                        depth: 2,
                        color: Colors.white,
                        lightSource: LightSource.bottomRight,
                        shadowLightColor: Colors.cyanAccent),
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                          fontFamily: 'instrument_serif',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 2.5,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 2.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NeumorphicButton(
                        onPressed: () => _googleButton(),
                        style: const NeumorphicStyle(
                            depth: 2,
                            lightSource: LightSource.bottomRight,
                            shadowLightColor: Colors.cyanAccent),
                        child: const SquareTile1(
                            imagePath: 'lib/Images/Google.jpg'),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      NeumorphicButton(
                        onPressed: () => _githubButton(),
                        style: const NeumorphicStyle(
                            depth: 2,
                            lightSource: LightSource.bottomRight,
                            shadowLightColor: Colors.cyanAccent),
                        child: const SquareTile1(
                            imagePath: 'lib/Images/github.png'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not a member ?',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontFamily: 'kalam'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () => goToHome(),
                        child: const Text(
                          'Register Now ',
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: 'kalam',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(10),
              right: Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyan),
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(10),
              right: Radius.circular(10),
            ),
          ),
          fillColor: Colors.grey[400],
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
              color: Colors.grey[700],
              fontFamily: 'instrument_serif',
              wordSpacing: 5,
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
      ),
    );
  }
}
