import 'package:flutter/material.dart';

Widget fromUser() {
  return Row(
    children: [
      CircleAvatar(radius: 30, backgroundColor: Colors.blue),
      SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('From: tekmeng (Dp: IT)'), Text('Date: 29 May 2025')],
      ),
    ],
  );
}
