import 'package:flutter/material.dart';
import 'package:online_doc_savimex/feature/screen/Doc_type/doc_type_screen.dart';
import 'package:online_doc_savimex/feature/screen/Login/login_screen.dart';
import 'package:online_doc_savimex/feature/screen/Upload/Upload_Document/upload_screen.dart';

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


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) => MaterialApp(home: UserListPage());
// }
//
// class UserListPage extends StatefulWidget {
//   @override
//   _UserListPageState createState() => _UserListPageState();
// }
//
// class _UserListPageState extends State<UserListPage> {
//   List users = [];
//
//   Future<void> fetchUsers() async {
//     final uri = Uri.parse('http://localhost:3000/users'); // Replace with your IP
//     final response = await http.get(uri);
//     if (response.statusCode == 200) {
//       setState(() {
//         users = json.decode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load users');
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchUsers();
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(title: Text('User List')),
//     body: users.isEmpty
//         ? Center(child: CircularProgressIndicator())
//         : ListView.builder(
//       itemCount: users.length,
//       itemBuilder: (_, index) => ListTile(
//         title: Text('${users[index]['id']},  ${users[index]['first_name']} ${users[index]['last_name']}'
//         ),
//       ),
//     ),
//   );
// }

