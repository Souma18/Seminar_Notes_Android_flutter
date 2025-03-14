import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class QuillEditorScreen extends StatefulWidget {
  @override
  _QuillEditorScreenState createState() => _QuillEditorScreenState();
}

class _QuillEditorScreenState extends State<QuillEditorScreen> {
  final quill.QuillController _controller = quill.QuillController.basic();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Quill Editor")),
      body: Column(
        children: [
          quill.QuillToolbar.simple(
            configurations: quill.QuillSimpleToolbarConfigurations(
              controller: _controller,
              // tắt bớt
              showAlignmentButtons: false, // Hiển thị căn chỉnh trái/phải/giữa
              showFontSize: false, // Hiển thị nút thay đổi cỡ chữ
              showFontFamily: false, // Hiển thị nút chọn font chữ
              showColorButton: false, // Hiển thị nút chọn màu chữ
              showBackgroundColorButton: false, // Hiển thị nút chọn màu nền chữ
              showListBullets: false, // Hiển thị danh sách dấu chấm
              showListNumbers: false, // Hiển thị danh sách số
              showCodeBlock: false, // Hiển thị nút chèn khối code
              showStrikeThrough: false, // Hiển thị nút gạch ngang chữ
              showHeaderStyle: false,//Hiển thị nút tùy chỉnh header
              showClipboardCut: false,//Hiển thị nút cut
              showClipboardCopy: false,//Hiển thị copy
              showClipboardPaste: false,//Hiển thị nút past

              showUnderLineButton: true, // Hiển thị nút gạch chân chữ
              showBoldButton: true,//nút in đậm
              showItalicButton: true,//nút in nghiêng

            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: quill.QuillEditor(
                configurations: quill.QuillEditorConfigurations(
                  controller: _controller,
                  textCapitalization: TextCapitalization.sentences, // Tùy chỉnh văn bản
                  padding: EdgeInsets.all(8), // Thêm padding nếu cần
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