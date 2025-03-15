import 'package:flutter/material.dart';
import 'package:notes_project/model/note.dart';
import 'package:notes_project/screens/note__creen.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final Function(Note) onNoteUpdated;

  const NoteItem({super.key, required this.note, required this.onNoteUpdated});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Chờ kết quả cập nhật ghi chú
        final updatedNote = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NoteDetailScreen(note: note)),
        );

        // Nếu ghi chú được cập nhật, gọi callback
        if (updatedNote != null) {
          onNoteUpdated(updatedNote);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hiển thị tiêu đề ghi chú
              Text(
                note.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Hiển thị nội dung ghi chú
              Text(
                note.content,
                style: const TextStyle(fontSize: 14),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),

              // Icon ghim ở góc dưới bên phải
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform.rotate(
                    angle: 50 * 3.1415927 / 180, // Nghiêng 50 độ
                    child: IconButton(
                      icon: const Icon(
                        Icons.push_pin_outlined,
                        color: Colors.blue,
                        size: 20,
                      ),
                      onPressed: () {
                        // TODO: Xử lý ghim ghi chú ở đây
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
