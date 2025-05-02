// screen/TrashScreen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/NoteProvider.dart';

class TrashScreen extends StatelessWidget {
  const TrashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NoteProvider>(context);
    final notes = provider.deletedNotes;

    return Scaffold(
      appBar: AppBar(title: const Text("Trash")),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text("Deleted at: ${note.deleteAt}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.restore),
                  onPressed: () => provider.restoreNote(note),
                ),
                IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: () => provider.removeNotePermanently(note),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
