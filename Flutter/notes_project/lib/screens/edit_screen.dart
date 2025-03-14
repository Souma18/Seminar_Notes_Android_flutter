import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'dart:convert'; // Để chuyển đổi JSON

class QuillEditorScreen extends StatefulWidget {
  @override
  _QuillEditorScreenState createState() => _QuillEditorScreenState();
}

class _QuillEditorScreenState extends State<QuillEditorScreen> {
  final quill.QuillController _controller = quill.QuillController.basic();
  @override
  void initState() {
    super.initState();
    _loadContent(); // 📌 Khi mở app, tải nội dung lên Quill
  }
  //  Hàm lưu nội dung editor
  void _saveContent() {
    // Chuyển nội dung từ Quill thành JSON

    final jsonContent = jsonEncode(_controller.document.toDelta().toJson());
    // Tạo note mới nếu chưa có
    // Gán thuộc tính content vào
    // lưu note hoặc cập nhật note
    // Hiển thị thông báo khi lưu xong
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Đã lưu nội dung!")),
    );

    // 🚀 Có thể lưu `jsonContent` vào file hoặc database ở đây
    print("Nội dung đã lưu: $jsonContent");
  }
  // 📌 Hàm tải nội dung JSON vào Quill
  void _loadContent() {
    // load content từ model
    String savedJson = '{"document": [{"insert": "Chào bạn! Đây là nội dung đã lưu.\\n"}]}';

    final data = jsonDecode(savedJson);
    final document = quill.Document.fromJson(data["document"]);

    setState(() {
      _controller.document = document; // Cập nhật trực tiếp nội dung của controller
    });

    print("Nội dung đã tải lên Quill!");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tiêu đề"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveContent, // 📌 Gọi hàm lưu khi nhấn
          ),
        ],
      ),
      body: Column(
        children: [
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
    );
  }

}

