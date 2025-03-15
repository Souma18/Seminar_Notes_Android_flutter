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
  List<Note> allNotes = NoteData.getNotes(); // Lưu danh sách gốc
  TextEditingController _searchController = TextEditingController();

  void _updateNote(Note updatedNote) {
    setState(() {
      final index = notes.indexWhere(
        (note) => note.noteId == updatedNote.noteId,
      );
      if (index != -1) {
        notes[index] = updatedNote;
      }

      // Cập nhật danh sách gốc để tìm kiếm không bị mất dữ liệu
      final originalIndex = allNotes.indexWhere(
        (note) => note.noteId == updatedNote.noteId,
      );
      if (originalIndex != -1) {
        allNotes[originalIndex] = updatedNote;
      }
    });
  }

  void _addNewNote() async {
    final newNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => NoteDetailScreen(
              note: Note(
                DateTime.now().millisecondsSinceEpoch,
                101,
                '',
                '',
                DateTime.now(),
                DateTime.now(),
                null,
              ),
            ),
      ),
    );

    if (newNote != null) {
      setState(() {
        notes.insert(0, newNote);
        allNotes.insert(0, newNote); // Cập nhật danh sách gốc
      });
    }
  }

  void _showUnlockDialog(BuildContext context, Note note) {
    String password = "";
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Mở khóa ghi chú"),
            content: TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: "Nhập mật khẩu"),
              onChanged: (value) {
                password = value;
              },
            ),
            actions: [
              TextButton(
                child: const Text("Hủy"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: const Text("Xác nhận"),
                onPressed: () {
                  if (password == note.passNote) {
                    Navigator.pop(context);
                    _openNoteDetail(context, note);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Mật khẩu sai!")),
                    );
                  }
                },
              ),
            ],
          ),
    );
  }

  void _openNoteDetail(BuildContext context, Note note) async {
    final updatedNote = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteDetailScreen(note: note)),
    );

    if (updatedNote != null) {
      _updateNote(updatedNote);
    }
  }

  void _searchNotes(String query) {
    setState(() {
      if (query.isEmpty) {
        notes = List.from(allNotes); // Trả về danh sách đầy đủ
      } else {
        notes =
            allNotes
                .where(
                  (note) =>
                      note.title.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              "Ghi chú",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _searchController,
                onChanged: _searchNotes,
                decoration: InputDecoration(
                  hintText: "Tìm kiếm...",
                  prefixIcon: const Icon(Icons.search, color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue.shade50,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: notes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            return NoteItem(
              note: notes[index],
              onNoteUpdated: _updateNote,
              onTap: () {
                if (notes[index].passNote != null) {
                  _showUnlockDialog(context, notes[index]);
                } else {
                  _openNoteDetail(context, notes[index]);
                }
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewNote,
        backgroundColor: Colors.lightBlue.shade100,
        child: const Icon(Icons.add, color: Colors.blue, size: 32),
      ),
    );
  }
}
