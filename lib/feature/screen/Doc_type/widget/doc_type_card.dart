import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_doc_savimex/feature/Model/document_type.dart';
import 'package:online_doc_savimex/feature/screen/Doc_type/set_doc_type_screen.dart';
import 'package:online_doc_savimex/feature/screen/Doc_type/create_doc_type_screen.dart';
import 'package:online_doc_savimex/feature/service/doctype_service.dart';

class DocTypeCard extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  final VoidCallback onDeleted;

  const DocTypeCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Column(
        children: [
          Row(
            children: [
              // Title & description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),

              // Action buttons
              Row(
                children: [
                  _iconClick(
                    icon: CupertinoIcons.hand_draw_fill,
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> SetDocumentTypeScreen())),
                  ),
                  const Text('/', style: TextStyle(color: Colors.white)),
                  _iconClick(
                      icon: Icons.edit,
                      onTap: () async{final changed = await Navigator.push<bool>(context, MaterialPageRoute(builder: (context)=> CreateDocumentTypeScreen(
                        existing: DocumentType(id: id, docTitle: title, docDesc: description),
                      )));
                        if(changed == true) onDeleted();
                      }),
                  const Text('/', style: TextStyle(color: Colors.white)),
                  _iconClick(
                    icon: CupertinoIcons.delete,
                    onTap: () => _confirmAndDelete(context),
                  ),
                ],
              ),
            ],
          ),
          const Divider(color: Colors.white24),
        ],
      ),
    );
  }

  Widget _iconClick({
    required IconData icon,
    required VoidCallback onTap,
    Color color = Colors.blue,
    double size = 20,
  }) {
    return IconButton(
      icon: Icon(icon, size: size, color: color),
      onPressed: onTap,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
    );
  }


  Future<void> _confirmAndDelete(BuildContext context) async {
    final ok = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Confirm delete'),
            content: Text('Delete "$title"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
    if (ok != true) return;
    try {
      await deleteDocType(id);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Deleted "$title"')));
      onDeleted();
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Delete failed: $e')));
    }
  }
}
