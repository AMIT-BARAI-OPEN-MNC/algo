import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class GlassmorphicButton extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color gradientColor1;
  final Color gradientColor2;
  final VoidCallback onPressed;

  const GlassmorphicButton({
    required Key key,
    required this.text,
    this.width = 200,
    this.height = 50,
    this.gradientColor1 = const Color(0xFFE0FFFF), // Light blue color
    this.gradientColor2 = const Color(0xFF7FFFD4), // Another light blue color
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlassmorphicContainer(
      width: width,
      height: height,
      borderRadius: 12,
      blur: 20,
      alignment: Alignment.center,
      border: 2,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [gradientColor1, gradientColor2],
        stops: [0.1, 0.9],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [gradientColor2, gradientColor1],
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
