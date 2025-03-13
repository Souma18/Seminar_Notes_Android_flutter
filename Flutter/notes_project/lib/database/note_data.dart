import 'package:notes_project/model/note.dart';

class NoteData {
  static List<Note> notes = [
    Note(
      1,
      101,
      "Ghi chú 1",
      "Nội dung ghi chú 1",
      DateTime.now(),
      DateTime.now(),
    ),
    Note(
      2,
      102,
      "Ghi chú 2",
      "Nội dung ghi chú 2",
      DateTime.now(),
      DateTime.now(),
      null, // deleteAt (đặt null nếu không có)
      null, // pinIndex (đặt null nếu không có)
      "1234", // passNote
    ),
    Note(
      3,
      103,
      "Ghi chú 3",
      "Nội dung ghi chú 3",
      DateTime.now(),
      DateTime.now(),
    ),
  ];

  static List<Note> getNotes() {
    return notes;
  }
}
