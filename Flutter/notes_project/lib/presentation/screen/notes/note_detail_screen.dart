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
  String? _passNote; // Biến để lưu mật khẩu tạm thời

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _passNote = widget.note.passNote; // Khởi tạo mật khẩu từ note ban đầu
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (_titleController.text.isNotEmpty ||
        _contentController.text.isNotEmpty) {
      final updatedNote = Note(
        widget.note.noteId,
        widget.note.accountId,
        _titleController.text,
        _contentController.text,
        widget.note.createAt,
        DateTime.now(),
        widget.note.deleteAt,
        widget.note.pinIndex,
        _passNote,
      );
      Navigator.pop(context, updatedNote);
    } else {
      Navigator.pop(context);
    }
  }

  void _managePassword() {
    if (_passNote == null) {
      _showSetPasswordDialog();
    } else {
      _showRemovePasswordDialog();
    }
  }

  void _showSetPasswordDialog() {
    String newPassword = '';
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Đặt mật khẩu"),
            content: TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: "Nhập mật khẩu mới"),
              onChanged: (value) {
                newPassword = value;
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
                  if (newPassword.isNotEmpty) {
                    setState(() {
                      _passNote = newPassword;
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Đã đặt mật khẩu!")),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Mật khẩu không được để trống!"),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
    );
  }

  void _showRemovePasswordDialog() {
    String passwordInput = '';
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Gỡ mật khẩu"),
            content: TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Nhập mật khẩu hiện tại",
              ),
              onChanged: (value) {
                passwordInput = value;
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
                  if (passwordInput == _passNote) {
                    setState(() {
                      _passNote = null;
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Đã gỡ mật khẩu!")),
                    );
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
            icon: Icon(
              _passNote == null ? Icons.lock_open : Icons.lock,
              color: _passNote == null ? Colors.grey : Colors.red,
            ),
            onPressed: _managePassword, // Gọi hàm quản lý mật khẩu
          ),
          IconButton(
            icon: const Icon(Icons.check, color: Colors.green),
            onPressed: _saveNote,
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
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
