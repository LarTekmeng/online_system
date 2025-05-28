// lib/models/document_type.dart

class DocumentType {
  final int? id;
  final String docTitle;
  final String docDesc;

  DocumentType({
    this.id,
    required this.docTitle,
    required this.docDesc,
  });

  factory DocumentType.fromJson(Map<String, dynamic> json) {
    return DocumentType(
      id: json['id'] as int?,
      docTitle: (json['doc_title'] as String) ?? '',
      docDesc:  (json['doc_desc'] as String) ?? '',
    );
  }
}
