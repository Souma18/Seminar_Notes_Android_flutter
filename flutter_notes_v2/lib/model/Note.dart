// model/Note.dart

class Note {
  int noteId;
  String title;
  String content;
  final int? pinIndex;
  String? passNote;
  DateTime createAt;
  DateTime? deleteAt;

  Note({
    required this.noteId,
    required this.title,
    required this.content,
    required this.pinIndex,
    required this.passNote,
    required this.createAt,
    required this.deleteAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'noteId': noteId,
      'title': title,
      'content': content,
      'pinIndex': pinIndex,
      'passNote': passNote,
      'createAt': createAt.toIso8601String(),
      'deleteAt': deleteAt?.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      noteId: map['noteId'],
      title: map['title'],
      content: map['content'],
      pinIndex: map['pinIndex'],
      passNote: map['passNote'],
      createAt: DateTime.parse(map['createAt']),
      deleteAt:
          map['deleteAt'] != null ? DateTime.parse(map['deleteAt']) : null,
    );
  }
}
