import 'package:flutter/material.dart';
import 'package:notes_project/model/note.dart';
import 'package:notes_project/screens/note__creen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Note> notes = [
    Note(
      1,
      101,
      "Ghi chú 1",
      "Nội dung ghi chú 1",
      DateTime.now(),
      DateTime.now(),
      null,
      null,
      null,
    ),
    Note(
      2,
      102,
      "Ghi chú 2",
      "Nội dung ghi chú 2",
      DateTime.now(),
      DateTime.now(),
      null,
      null,
      "1234",
    ), // Có passNote
    Note(
      3,
      103,
      "Ghi chú 3",
      "Nội dung ghi chú 3",
      DateTime.now(),
      DateTime.now(),
      null,
      null,
      null,
    ),
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: "Tìm kiếm ghi chú...",
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: TextStyle(color: Colors.white),
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
        ),
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          if (searchQuery.isNotEmpty &&
              !note.title.toLowerCase().contains(searchQuery.toLowerCase())) {
            return SizedBox.shrink();
          }
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: Icon(
                note.passNote != null ? Icons.lock : Icons.note,
                color: Colors.blueAccent,
              ),
              title: Text(note.title),
              subtitle: Text(
                note.passNote != null ? "🔒 Đã khóa" : note.content,
              ),
              onTap: () {
                if (note.passNote != null) {
                  _showUnlockDialog(context, note);
                } else {
                  _openNoteDetail(context, note);
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Nút mở menu
        onPressed: () {
          _showMenu();
        },
        child: Icon(Icons.menu),
      ),
    );
  }

  void _showMenu() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.add),
                title: Text("Thêm ghi chú"),
                onTap: () {
                  Navigator.pop(context);
                  // Chuyển đến trang thêm ghi chú
                },
              ),
              ListTile(
                leading: Icon(Icons.archive),
                title: Text("Kho lưu trữ"),
                onTap: () {
                  Navigator.pop(context);
                  // Mở kho lưu trữ
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text("Kho đã xóa"),
                onTap: () {
                  Navigator.pop(context);
                  // Mở kho đã xóa
                },
              ),
            ],
          ),
    );
  }

  // Hộp thoại nhập mật khẩu
  void _showUnlockDialog(BuildContext context, Note note) {
    String password = "";
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Mở khóa ghi chú"),
            content: TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Nhập mật khẩu"),
              onChanged: (value) {
                password = value;
              },
            ),
            actions: [
              TextButton(
                child: Text("Hủy"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Xác nhận"),
                onPressed: () {
                  if (password == note.passNote) {
                    Navigator.pop(context);
                    _openNoteDetail(context, note);
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Mật khẩu sai!")));
                  }
                },
              ),
            ],
          ),
    );
  }

  // Chuyển đến trang xem chi tiết ghi chú
  void _openNoteDetail(BuildContext context, Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteDetailScreen(note: note)),
    );
  }
}
