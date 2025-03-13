import 'package:flutter/material.dart';
import 'package:notes_project/model/note.dart';

class NoteDetailScreen extends StatelessWidget {
  final Note note;
  NoteDetailScreen({required this.note});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(
      text: note.title,
    );
    TextEditingController contentController = TextEditingController(
      text: note.content,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết ghi chú"),
        actions: [
          IconButton(
            icon: Icon(Icons.lock),
            onPressed: () {
              // Đặt mật khẩu cho ghi chú
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Tiêu đề"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: InputDecoration(labelText: "Nội dung"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lưu ghi chú
              },
              child: Text("Lưu"),
            ),
          ],
        ),
      ),
    );
  }
}
