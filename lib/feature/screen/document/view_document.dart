import 'package:flutter/material.dart';
import 'package:online_doc_savimex/feature/screen/document/widget/first_section.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DocumentScreen(),
  ));
}

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            fromUser(),
            const Divider(),
            const TimelineStep(
              step: 1,
              name: "Pheak (HR)",
              status: "Checked",
              date: "1 January 2031",
              color: Colors.green,
            ),
            const TimelineStep(
              step: 2,
              name: "Rith (Accounting)",
              status: "Checked",
              date: "2 January 2031",
              color: Colors.green,
            ),
            const TimelineStep(
              step: 3,
              name: "Boss (CEO)",
              status: "Approved",
              date: "5 January 2031",
              color: Colors.blue,
            ),
            const Divider(),
            const SizedBox(height: 10),
            const Text("Document Title",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("This is the main description of this document..."),
            const SizedBox(height: 10),
            const DocumentBox(from: "Pheak (HR)"),
            const DocumentBox(from: null),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.attachment),
              Icon(Icons.chat_bubble_outline),
            ],
          ),
        ),
      ),
    );
  }
}

class TimelineStep extends StatelessWidget {
  final int step;
  final String name;
  final String status;
  final String date;
  final Color color;

  const TimelineStep({
    super.key,
    required this.step,
    required this.name,
    required this.status,
    required this.date,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: Text('$step', style: const TextStyle(color: Colors.white)),
            ),
            if (step < 3)
              Container(width: 2, height: 30, color: Colors.grey.shade400),
          ],
        ),
        const SizedBox(width: 12),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "$name → "),
              TextSpan(
                text: "$status",
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
              TextSpan(text: " - $date"),
            ],
          ),
        ),
      ],
    );
  }
}

class DocumentBox extends StatelessWidget {
  final String? from;

  const DocumentBox({super.key, this.from});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (from != null) Text("From: $from"),
        Container(
          margin: const EdgeInsets.only(top: 4, bottom: 16),
          height: 150,
          color: Colors.grey.shade300,
          alignment: Alignment.center,
          child: Transform.rotate(
            angle: -0.3,
            child: const Text(
              "This is Document",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
