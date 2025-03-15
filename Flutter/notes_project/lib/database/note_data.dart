import 'dart:convert';
import 'package:notes_project/model/note.dart';

class NoteData {
  static List<Note> notes = [
    Note(
      1,
      101,
      "Lịch họp nhóm",
      jsonEncode([{"insert": "Cuộc họp dự án Flutter vào 14h thứ Sáu.\n"}]),
      DateTime(2024, 3, 1, 10, 0),
      DateTime(2024, 3, 2, 15, 30),
    ),
    Note(
      2,
      102,
      "Mật khẩu WiFi",
      jsonEncode([{"insert": "WiFi thư viện: Library_5G, mật khẩu: 987654321.\n"}]),
      DateTime(2024, 2, 20, 9, 0),
      DateTime(2024, 2, 21, 10, 30),
      null,
      1, // Ghim lên đầu
    ),
    Note(
      3,
      103,
      "Danh sách mua sắm",
      jsonEncode([
        {"insert": "- Sữa\n- Bánh mì\n- Trứng\n- Nước cam\n"}
      ]),
      DateTime(2024, 3, 5, 18, 0),
      DateTime(2024, 3, 5, 19, 15),
    ),
    Note(
      4,
      104,
      "Thông tin tài khoản",
      jsonEncode([{"insert": "Ngân hàng ABC, số tài khoản: 1234567890.\n"}]),
      DateTime(2024, 1, 10, 11, 20),
      DateTime(2024, 2, 10, 12, 45),
      null,
      null,
      "bank123", // Có mật khẩu
    ),
    Note(
      5,
      105,
      "Lịch tập thể dục",
      jsonEncode([
        {"insert": "Chạy bộ: 6h - 6h30\nTập gym: 18h - 19h\n"}
      ]),
      DateTime(2024, 3, 10, 6, 0),
      DateTime(2024, 3, 10, 6, 30),
    ),
    Note(
      6,
      106,
      "Công thức món ăn",
      jsonEncode([{"insert": "Cách làm bánh pancake: trứng, sữa, bột mì, đường...\n"}]),
      DateTime(2024, 2, 5, 15, 45),
      DateTime(2024, 2, 6, 16, 30),
      DateTime(2024, 3, 1), // Đã xóa
    ),
    Note(
      7,
      107,
      "Dự án lập trình",
      jsonEncode([{"insert": "Cần hoàn thành chức năng login trước thứ 4.\n"}]),
      DateTime(2024, 3, 8, 13, 0),
      DateTime(2024, 3, 8, 17, 20),
    ),
    Note(
      8,
      108,
      "Danh sách việc cần làm",
      jsonEncode([
        {"insert": "- Hoàn thành báo cáo.\n"},
        {"insert": "- Nộp bài tập nhóm.\n"},
        {"insert": "- Đi họp phụ huynh.\n"}
      ]),
      DateTime(2024, 3, 9, 8, 0),
      DateTime(2024, 3, 9, 9, 30),
      null,
      2, // Ghim lên đầu
    ),
  ];

  static List<Note> getNotes() {
    return notes;
  }

  // Thêm ghi chú
  static void addNote(Note note) {
    notes.add(note); // Thêm vào danh sách
  }

  // Cập nhật ghi chú
  static void updateNote(Note updatedNote) {
    int index = notes.indexWhere((note) => note.noteId == updatedNote.noteId);
    if (index != -1) {
      notes[index] = updatedNote; // Cập nhật nội dung
    }
  }

  // Xóa ghi chú
  static void deleteNote(int id) {
    notes.removeWhere((note) => note.noteId == id);
  }
}
