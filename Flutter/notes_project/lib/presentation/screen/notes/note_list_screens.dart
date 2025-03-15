import 'package:flutter/material.dart';
import 'package:notes_project/database/note_data.dart';
import 'package:notes_project/model/note.dart';
import 'package:notes_project/presentation/widget/note_item.dart';
import 'note_detail_screen.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<Note> notes = NoteData.getNotes();

  // Cập nhật ghi chú khi có thay đổi
  void _updateNote(Note updatedNote) {
    setState(() {
      final index = notes.indexWhere(
        (note) => note.noteId == updatedNote.noteId,
      );
      if (index != -1) {
        notes[index] = updatedNote;
      }
    });
  }

  // Thêm ghi chú mới
  void _addNewNote() async {
    final newNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => NoteDetailScreen(
              note: Note(
                DateTime.now().millisecondsSinceEpoch,
                101, // Giả định ID tài khoản
                '',
                '',
                DateTime.now(),
                DateTime.now(),
              ),
            ),
      ),
    );

    if (newNote != null) {
      setState(() {
        notes.insert(0, newNote); // Thêm ghi chú mới vào đầu danh sách
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Note> notes = NoteData.getNotes();

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      // Nền bao trọn cả màn hình, giảm màu xanh
      appBar: AppBar(
        title: const Text(
          "Ghi chú",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade50, // Đồng bộ màu nền với màn hình
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: notes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Hiển thị 2 cột
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return NoteItem(note: notes[index], onNoteUpdated: _updateNote);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewNote, //Mở màn hình tạo ghi chú mới
        backgroundColor: Colors.lightBlue.shade100, // Màu nền xanh biển nhạt
        child: const Icon(
          Icons.add,
          color: Colors.blue, // Màu xanh biển đậm
          size: 32,
        ),
      ),
    );
  }
}
