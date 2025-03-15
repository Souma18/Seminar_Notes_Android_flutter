import 'package:flutter/material.dart';
import 'package:notes_project/model/note.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note note;

  const NoteDetailScreen({super.key, required this.note});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_titleController.text.isNotEmpty || _contentController.text.isNotEmpty) {
      final updatedNote = Note(
        widget.note.noteId,
        widget.note.accountId,
        _titleController.text,
        _contentController.text,
        widget.note.createAt,
        DateTime.now(), // Cập nhật thời gian sửa đổi
      );
      Navigator.pop(context, updatedNote); // Trả kết quả về màn hình chính
    } else {
      Navigator.pop(context); // Không lưu nếu không có nội dung
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ghi chú',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: _saveNote, // Lưu khi ấn vào dấu tích
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: 'Tiêu đề',
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TextField(
                controller: _contentController,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: 'Nội dung ghi chú...',
                  border: InputBorder.none,
                ),
                maxLines: null, // Cho phép nhập nhiều dòng
                keyboardType: TextInputType.multiline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
