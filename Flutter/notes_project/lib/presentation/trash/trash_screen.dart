import 'package:flutter/material.dart';
import 'package:notes_project/providers/trash_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:notes_project/screens/home_screen.dart'; // Import màn hình chính

class TrashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final trashViewModel = Provider.of<TrashViewModel>(context);
    final deletedNotes = trashViewModel.deletedNotes;

    return Scaffold(
      appBar: AppBar(
        title: Text("Thùng rác"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()), // Quay lại màn hình chính
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: deletedNotes.isNotEmpty
                ? () {
              trashViewModel.restoreAllNotes();
              _navigateToHome(context); // Quay lại HomeScreen
            }
                : null,
          ),
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: deletedNotes.isNotEmpty
                ? () {
              trashViewModel.deleteAllNotes();
              _navigateToHome(context); // Quay lại HomeScreen
            }
                : null,
          ),
        ],
      ),
      body: deletedNotes.isEmpty
          ? Center(child: Text("Không có ghi chú nào trong thùng rác."))
          : ListView.builder(
        itemCount: deletedNotes.length,
        itemBuilder: (context, index) {
          final note = deletedNotes[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: Icon(
                note.passNote != null ? Icons.lock : Icons.delete,
                color: Colors.redAccent,
              ),
              title: Text(note.title),
              subtitle: Text(
                note.passNote != null ? "🔒 Đã khóa" : note.content,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.restore, color: Colors.green),
                    onPressed: () {
                      trashViewModel.restoreNote(note);
                      _checkAndNavigateHome(context, trashViewModel);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_forever, color: Colors.red),
                    onPressed: () {
                      trashViewModel.deleteNotePermanently(note);
                      _checkAndNavigateHome(context, trashViewModel);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Điều hướng về HomeScreen khi thùng rác trống
  void _checkAndNavigateHome(BuildContext context, TrashViewModel trashViewModel) {
    if (trashViewModel.deletedNotes.isEmpty) {
      _navigateToHome(context);
    }
  }

  // Điều hướng về HomeScreen
  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
