import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dotted_border/dotted_border.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final _formKey = GlobalKey<FormState>();
  String? selectedDocumentType;
  DateTime? selectedDate;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController fileDescriptionController = TextEditingController();

  bool showFileDescription = false;

  List<int> additionalFiles = [];
  int fileIdCounter = 0;

  void _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    fileDescriptionController.dispose();
    super.dispose();
  }

  Widget buildUploadBlock({VoidCallback? onRemove}) {
    return Stack(
      children: [
        DottedBorder(
          borderType: BorderType.RRect,
          radius: const Radius.circular(8),
          dashPattern: [6, 3],
          color: Colors.black45,
          strokeWidth: 1,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.cloud_upload_outlined, size: 40),
                const SizedBox(height: 8),
                Text(
                   'Click to browse file',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Text('drag and drop file here', style: TextStyle(color: Colors.black54)),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showFileDescription = !showFileDescription;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          showFileDescription ? Icons.undo : Icons.add_circle_outline,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          showFileDescription ? 'Undo' : 'Add Description',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  if(showFileDescription)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      controller: fileDescriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Enter file description...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (onRemove != null)
          Positioned(
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.undo, color: Colors.red),
              onPressed: onRemove,
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Document form',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LabelWithAsterisk('Document title'),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'document title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                const LabelWithAsterisk('Document type'),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          hintText: 'choose document type',
                          border: OutlineInputBorder(),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'type1', child: Text('Type 1')),
                          DropdownMenuItem(value: 'type2', child: Text('Type 2')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedDocumentType = value;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.blue),
                      onPressed: () {
                        // Add new document type logic
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                const Text('Description (optional):'),
                const SizedBox(height: 8),
                TextFormField(
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'type here...',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                const LabelWithAsterisk('Upload your file: (image, pdf, word, excel...)'),
                const SizedBox(height: 8),
                buildUploadBlock(),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      additionalFiles.add(fileIdCounter++);
                    });
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.add_circle_outline, color: Colors.blue),
                      SizedBox(width: 4),
                      Text('Add more file', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                if (additionalFiles.isNotEmpty)
                  Column(
                    children: [
                      for (var id in additionalFiles)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: buildUploadBlock(
                            onRemove: () {
                              setState(() {
                                additionalFiles.remove(id);
                              });
                            },
                          ),
                        ),
                    ],
                  ),

                const SizedBox(height: 16),
                const Text('Schedule date'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  onTap: _pickDate,
                  decoration: const InputDecoration(
                    hintText: 'dd/mm/yyyy',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),

                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // Submit logic
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LabelWithAsterisk extends StatelessWidget {
  final String label;
  const LabelWithAsterisk(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(color: Colors.black, fontSize: 16),
        children: const [
          TextSpan(
            text: ' *',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
