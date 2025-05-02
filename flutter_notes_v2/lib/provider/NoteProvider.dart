// provider/NoteProvider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/Note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get activeNotes =>
      _notes.where((n) => n.deleteAt == null).toList();
  List<Note> get deletedNotes =>
      _notes.where((n) => n.deleteAt != null).toList();

  NoteProvider() {
    loadNotes();
  }

  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('notes') ?? '[]';
    final jsonList = json.decode(jsonString) as List;
    _notes = jsonList.map((e) => Note.fromMap(e)).toList();
    notifyListeners();
  }

  Future<void> saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(_notes.map((e) => e.toMap()).toList());
    await prefs.setString('notes', jsonString);
  }

  void addNote(Note note) {
    _notes.add(note);
    saveNotes();
    notifyListeners();
  }

  void updateNote(Note note) {
    final index = _notes.indexWhere((n) => n.noteId == note.noteId);
    if (index != -1) {
      _notes[index] = note;
      saveNotes();
      notifyListeners();
    }
  }

  void deleteNote(Note note) {
    note.deleteAt = DateTime.now();
    saveNotes();
    notifyListeners();
  }

  void restoreNote(Note note) {
    note.deleteAt = null;
    saveNotes();
    notifyListeners();
  }

  void removeNotePermanently(Note note) {
    _notes.removeWhere((n) => n.noteId == note.noteId);
    saveNotes();
    notifyListeners();
  }
}
