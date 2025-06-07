import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../service/employee_service.dart';
import '../../Doc_type/doc_type_screen.dart';
import '../../Login/login_screen.dart';

class DrawerHomeScreen extends StatefulWidget {
  final int employeeID;
  const DrawerHomeScreen({super.key, required this.employeeID});

  @override
  State<DrawerHomeScreen> createState() => _DrawerHomeScreenState();
}

class _DrawerHomeScreenState extends State<DrawerHomeScreen> {
  Map<String, dynamic>? _employeeData;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    try {
      final resp = await fetchUserById(widget.employeeID);
      setState(() {
        _employeeData = resp['employee'];
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                  AssetImage('assets/images/tiger-beer-logo.jpg'),
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID: ${_employeeData?['id'] ?? "..."}',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      'Name: ${_employeeData?['employee_name'] ?? "..."}',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      'DEP: ${_employeeData?['dp_name'] ?? "..."}',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.type_specimen),
            title: const Text('Document Type'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    DocumentTypeScreen(employeeID: widget.employeeID),
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.archive),
            title: Text('Archive'),
          ),
          const ListTile(
            leading: Icon(Icons.delete),
            title: Text('Trash'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const LoginScreen())),
          ),
        ],
      ),
    );
  }
}
