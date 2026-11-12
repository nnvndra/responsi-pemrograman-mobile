/// Model data untuk catatan kuliah (metadata dan isi).
class Note {
  final String id;
  final String title;
  final DateTime createdAt;
  final String content;

  const Note({
    required this.id,
    required this.title,
    required this.createdAt,
    this.content = '',
  });

  /// Mengonversi metadata catatan menjadi Map (tanpa isi sensitif).
  Map<String, dynamic> toMetadataJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Membuat objek [Note] dari Map metadata JSON.
  factory Note.fromMetadataJson(Map<String, dynamic> json, {String content = ''}) {
    return Note(
      id: json['id'] as String,
      title: json['title'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      content: content,
    );
  }
}