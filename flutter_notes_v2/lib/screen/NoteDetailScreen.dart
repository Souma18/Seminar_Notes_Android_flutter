import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/Note.dart';
import '../provider/NoteProvider.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note? note;

  const NoteDetailScreen({super.key, this.note});

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
      _passController.text = widget.note!.passNote ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isNew = widget.note == null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? "New Note" : "Edit Note"),
        actions: [
          if (!isNew)
            IconButton(icon: const Icon(Icons.save), onPressed: _saveNote),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              maxLines: 10,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password (optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saveNote,
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("SAVE"),
            ),
          ],
        ),
      ),
    );
  }

  void _saveNote() {
    final provider = Provider.of<NoteProvider>(context, listen: false);
    final note = Note(
      noteId: widget.note?.noteId ?? DateTime.now().millisecondsSinceEpoch,
      title: _titleController.text,
      content: _contentController.text,
      passNote: _passController.text.isEmpty ? null : _passController.text,
      pinIndex: null,
      createAt: widget.note?.createAt ?? DateTime.now(),
      deleteAt: widget.note?.deleteAt,
    );

    if (widget.note == null) {
      provider.addNote(note);
    } else {
      provider.updateNote(note);
    }
    Navigator.pop(context);
  }
}
