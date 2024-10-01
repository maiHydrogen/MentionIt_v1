import 'package:baatcheet/models/chatuser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Chatusercard extends StatefulWidget {
   final ChatUser user;
  const Chatusercard({super.key, required this.user});

  @override
  State<Chatusercard> createState() => _ChatusercardState();
}

class _ChatusercardState extends State<Chatusercard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(vertical:4,
      horizontal: MediaQuery.of(context).size.width*0.04),
      child: InkWell(
        onTap: (){},
        child: ListTile(
          leading: const CircleAvatar(backgroundColor: Colors.cyan,child:Icon(FontAwesomeIcons.person,size: 25,color: Colors.white,),),
          title: Text(widget.user.Name,
          style: const TextStyle(color: Colors.white),),
          subtitle: Text(widget.user.About,
            style: const TextStyle(color: Colors.white),),
          trailing: const Text('12:00 AM',
            style: TextStyle(color: Colors.white),),
        ),
      )
    );
  }
}
