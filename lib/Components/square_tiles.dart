import 'package:flutter/material.dart';

class SquareTile1 extends StatelessWidget {
  final String imagePath;
  const SquareTile1({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black,)),
      child: ClipRRect(borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          height: 20,
        ),
      ),
    );
  }
}

class SquareTile2 extends StatelessWidget {
  final String imagePath;
  const SquareTile2({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}
