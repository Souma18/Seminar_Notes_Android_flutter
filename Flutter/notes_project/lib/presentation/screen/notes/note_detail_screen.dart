// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:notes_project/model/note.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'dart:convert'; // Để chuyển đổi JSON

class NoteDetailScreen extends StatefulWidget {
  final Note note;

  const NoteDetailScreen({super.key, required this.note});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController _titleController;
  // late TextEditingController _contentController;
  final quill.QuillController _controller = quill.QuillController.basic();

  @override
  void initState() {
    super.initState();
    _loadContent(); // 📌 Khi mở app, tải nội dung lên Quill
    _titleController = TextEditingController(text: widget.note.title);
    // _contentController = TextEditingController(text: widget.note.content);
  }

  void _loadContent() {
    // load content từ model
    final List<dynamic> data = jsonDecode(jsonEncode(widget.note.content)); // ✅ Chuyển về List hợp lệ
    final document = quill.Document.fromJson(data.cast<Map<String, dynamic>>());

    // final document = quill.Document.fromJson(data["document"]);

    setState(() {
      _controller.document = document; // Cập nhật trực tiếp nội dung của controller
    });
    // print("Nội dung đã tải lên Quill!");
  }

  @override
  void dispose() {
    _titleController.dispose();
    // _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    if (!_controller.document.isEmpty()) {
      final contentJson = jsonEncode(_controller.document.toDelta().toJson());
      print("Nội dung lưu: $contentJson"); // Kiểm tra nội dung

      final updatedNote = Note(
        widget.note.noteId,
        widget.note.accountId,
        _titleController.text,
        contentJson,
        widget.note.createAt,
        DateTime.now(),
      );

      Navigator.pop(context, updatedNote); // Trả dữ liệu về màn hình trước
    } else {
      print("⚠️ Nội dung trống, không lưu.");
      Navigator.pop(context);
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
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: 'Tiêu đề',
                border: InputBorder.none,
              ),
            ),
            quill.QuillToolbar.simple(
              configurations: quill.QuillSimpleToolbarConfigurations(
                controller: _controller,
                showBoldButton: true,
                showItalicButton: true,
                showUnderLineButton: true,
                showColorButton: true,

                // Tắt tất cả các nút khác
                showAlignmentButtons: false,
                showFontSize: false,
                showFontFamily: false,
                showBackgroundColorButton: false,
                showListBullets: false,
                showListNumbers: false,
                showCodeBlock: false,
                showStrikeThrough: false,
                showHeaderStyle: false,
                showIndent: false,
                showInlineCode: false,
                showDividers: false,
                showSearchButton: false,
                showUndo: false,
                showRedo: false,
                showLink: false,
                showSubscript: false,
                showSuperscript: false,
                showClearFormat: false,
                showDirection: false,
                showJustifyAlignment: false,
                showCenterAlignment: false,
                showLeftAlignment: false,
                showRightAlignment: false,
                showClipboardCut: false,
                showClipboardCopy: false,
                showClipboardPaste: false,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: quill.QuillEditor(
                  configurations: quill.QuillEditorConfigurations(
                    controller: _controller,
                    enableInteractiveSelection: true,
                    padding: EdgeInsets.all(8),
                  ),
                  focusNode: FocusNode(),
                  scrollController: ScrollController(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
