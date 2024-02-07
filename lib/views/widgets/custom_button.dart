import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onpress;
  final String title;
  final IconButton? prefixiIcon;
  const CustomButton({
    super.key,
    required this.title,
    required this.onpress,
    this.prefixiIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Container(
        alignment: Alignment.center,
        width: 334,
        height: 48,
        decoration: ShapeDecoration(
          color: Colors.cyan,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          title,
          style: const TextStyle(
            letterSpacing: 3,
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
