import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
final String btnName;
  final Color colour;
  final double containWidth;
  final double containHeight;
  final double radius;
  final VoidCallback onPressed;
  const Buttons({super.key, required this.btnName, required this.colour, required this.containWidth, required this.containHeight, required this.radius, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: onPressed,
    child: Container(
      
      // padding: const EdgeInsets.symmetric(horizontal:30, vertical: 6),
      padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
      width: containWidth,
      height: containHeight,
      decoration: BoxDecoration(color: colour,
      borderRadius: BorderRadius.circular(radius),
      //border: Border.all(width: 1)
       ),
      
      child: Center(
        child: Text(btnName, style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),),
      )
      
    )
    );
  }
}