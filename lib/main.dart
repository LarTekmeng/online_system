import 'package:flutter/material.dart';
import 'package:online_doc_savimex/feature/screen/signIn_signUp/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/' : (context) => LoginScreen(),
      },
    );
  }
}