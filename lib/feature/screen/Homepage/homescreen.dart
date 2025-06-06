import 'package:flutter/material.dart';
import 'package:online_doc_savimex/feature/Model/document.dart';
import 'package:online_doc_savimex/feature/screen/Homepage/widget/doc_list.dart';
import 'package:online_doc_savimex/feature/screen/Homepage/widget/drawer_home_screen.dart';
import 'package:online_doc_savimex/feature/screen/Upload/Upload_Document/upload_screen.dart';
import 'package:online_doc_savimex/feature/service/document_service.dart';
import 'package:online_doc_savimex/feature/widget/button.dart';
import 'package:online_doc_savimex/feature/widget/search.dart';
import '../../service/employee_service.dart';

class Homescreen extends StatefulWidget {
  final int employeeID;
  const Homescreen({super.key, required this.employeeID});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Future<List<Document>> _futureDocument;

  Map<String, dynamic>? _employeeData;
  bool _loading = true;
  String? _error;
  bool _isEdit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUser();
    _loadDocument();
  }

  void _loadDocument() {
    setState(() {
      _futureDocument = fetchDocument();
    });
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
    return Scaffold(
      backgroundColor: const Color(0xFF006080),
      drawer: _isEdit? null : DrawerHomeScreen(employeeID: widget.employeeID),
      appBar: AppBar(
        leading: _isEdit? TextButton(onPressed: (){}, child: Text('Select all', style: TextStyle(color: Colors.yellow),)) : null,
        backgroundColor: const Color(0xFF006080),
        elevation: 0,
        title: const Text(
          'Document',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: TextButton(onPressed: (){
              setState(() {
                _isEdit = !_isEdit;
              });
            }, child: Text(_isEdit? 'Cancel':'Edit',style: TextStyle(color: Colors.yellow),)),
          ),
        ],
        iconTheme: const IconThemeData(
          color: Colors.yellow,
        ), // drawer icon color
      ), // Background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bara
              SearchBarField(showIcon: true),
              const SizedBox(height: 16),
              // Scrollable Document List
              Expanded(
                child: FutureBuilder(
                  future: _futureDocument,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    final docData = snapshot.data!;
                    if (docData.isEmpty) {
                      return Center(child: Text('No Document Data is Found!'));
                    }
                    return ListView.builder(
                      itemCount: docData.length,
                      itemBuilder: (context, index) {
                        final doc = docData[index];
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(_isEdit)...[
                              Checkbox(value: false,
                               onChanged: (val){
                               },
                               shape: CircleBorder(),
                               )
                            ],
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: _isEdit? 5.0 : 0.0),
                                child: DocumentItem(
                                  title: doc.title,
                                  status: 'In Progress',
                                  desc: doc.description,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              //Floating List action
              if(_isEdit)
              btnListAction(),

              SizedBox(height: 10,),
              //Click button to Upload document
              mainButton(
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            UploadScreen(employeeID: widget.employeeID),
                  ),
                ),
                'New Document',
                Colors.green,
              ),
              const SizedBox(height: 8), // Padding below button
            ],
          ),
        ),
      ),
    );
  }
}
