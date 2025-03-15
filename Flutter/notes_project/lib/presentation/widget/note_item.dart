import 'package:flutter/material.dart';
import 'package:notes_project/model/note.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  final ValueChanged<Note> onNoteUpdated;

  const NoteItem({
    Key? key,
    required this.note,
    required this.onTap,
    required this.onNoteUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề + Biểu tượng khóa (nếu có)
            Row(
              children: [
                Expanded(
                  child: Text(
                    note.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (note.passNote != null)
                  Icon(Icons.lock, color: Colors.black),
              ],
            ),
            SizedBox(height: 8),

            Expanded(
              child: Text(
                note.passNote == null ? note.content : "••••••••••••••••••••",
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  color:
                      note.passNote == null
                          ? Colors.grey[600]
                          : Colors.grey[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
