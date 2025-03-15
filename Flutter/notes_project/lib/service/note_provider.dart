import 'package:flutter/material.dart';
import 'package:notes_project/database/note_data.dart';
import 'package:notes_project/model/note.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = []; // Danh sách ghi chú hiển thị
  List<Note> _allNotes = []; // Danh sách ghi chú gốc

  NoteProvider() {
    _loadNotes();
  }

  List<Note> get notes => _notes;

  void _loadNotes() {
    _allNotes = NoteData.getNotes(); // Lấy tất cả ghi chú
    _notes = List.from(_allNotes); // Gán cho danh sách hiển thị
    notifyListeners();
  }

  void addNote(Note note) {
    NoteData.addNote(note); // Lưu ghi chú vào cơ sở dữ liệu hoặc danh sách
    _allNotes.add(note); // Cập nhật danh sách gốc
    _notes = List.from(_allNotes); // Cập nhật danh sách hiển thị
    notifyListeners(); // Cập nhật UI
  }

  void searchNotes(String query) {
    if (query.isEmpty) {
      _notes = List.from(
        _allNotes,
      ); // Trả về toàn bộ ghi chú khi không tìm kiếm
    } else {
      _notes =
          _allNotes
              .where(
                (note) =>
                    note.title.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    }
    notifyListeners();
  }

  void updateNote(Note oldNote, String newTitle, String newContent) {
    final noteIndex = _notes.indexOf(oldNote);
    if (noteIndex != -1) {
      _notes[noteIndex] = oldNote.copyWith(
        title: newTitle,
        content: newContent,
        updateAt: DateTime.now(),
      );
      notifyListeners();
    }
  }
}
