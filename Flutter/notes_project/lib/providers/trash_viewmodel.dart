import 'package:flutter/material.dart';
import 'package:notes_project/model/note.dart';

class TrashViewModel with ChangeNotifier {
  List<Note> _deletedNotes = [
    Note(1, 101, "Ghi chú 1", "Nội dung ghi chú 1", DateTime.now(), DateTime.now(), DateTime.now(), null, null),
    Note(2, 102, "Ghi chú 2", "Nội dung ghi chú 2", DateTime.now(), DateTime.now(), DateTime.now(), null, "1234"),
    Note(3, 103, "Ghi chú 3", "Nội dung ghi chú 3", DateTime.now(), DateTime.now(), DateTime.now(), null, null),
  ];

  List<Note> get deletedNotes => _deletedNotes;

  void restoreNote(Note note) {
    note.deleteAt = null;
    _deletedNotes.remove(note);
    notifyListeners();
  }

  void deleteNotePermanently(Note note) {
    _deletedNotes.remove(note);
    notifyListeners();
  }

  void restoreAllNotes() {
    _deletedNotes.clear();
    notifyListeners();
  }

  void deleteAllNotes() {
    _deletedNotes.clear();
    notifyListeners();
  }
}
