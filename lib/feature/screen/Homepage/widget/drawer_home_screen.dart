import 'package:flutter/material.dart';
import 'package:online_doc_savimex/feature/screen/Doc_type/doc_type_screen.dart';
import 'package:online_doc_savimex/feature/screen/Login/login_screen.dart';

import '../../../service/employee_service.dart';

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
    // TODO: implement initState
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/tiger-beer-logo.jpg'),
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start ,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('ID: ${_employeeData?['id']}',style: TextStyle(color: Colors.white, fontSize: 14),),
                    Text('Name: ${_employeeData?['employee_name']}',style: TextStyle(color: Colors.white, fontSize: 14),),
                    Text('DEP: ${_employeeData?['dp_name']}',style: TextStyle(color: Colors.white, fontSize: 14),),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => DocumentTypeScreen(employeeID: widget.employeeID,)));
            },
            leading: const Icon(Icons.type_specimen),
            title: const Text('Document Type'),
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
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
            },
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

