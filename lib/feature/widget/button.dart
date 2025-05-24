import 'package:flutter/material.dart';

Widget mainButton(VoidCallback onTap, String text, Color color) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
    ),
    onPressed: onTap,
    child: Text(text, style: TextStyle(fontSize: 18, color: Colors.white)),
  );
}
