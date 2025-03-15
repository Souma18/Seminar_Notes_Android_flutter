import 'package:flutter/material.dart';
import 'package:notes_project/model/note.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final Function(Note) onNoteUpdated;
  final VoidCallback onTap;

  const NoteItem({
    super.key,
    required this.note,
    required this.onNoteUpdated,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Sử dụng trực tiếp onTap được truyền từ NoteListScreen
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Text(
                note.content.isNotEmpty
                    ? note.content
                    .where((e) => e.containsKey('insert') && e['insert'] is String) // Lọc phần tử hợp lệ
                    .map((e) => e['insert'] as String) // Lấy nội dung
                    .join(" ") // Ghép thành chuỗi
                    : "Không có nội dung",
                style: const TextStyle(fontSize: 14),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),

              const Spacer(),
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
