import 'package:notes_project/model/note.dart';

class NoteData {
  static List<Note> notes = [
    Note(
      1,
      101,
      "Lịch họp nhóm",
      "Cuộc họp dự án Flutter vào 14h thứ Sáu.",
      DateTime(2024, 3, 1, 10, 0),
      DateTime(2024, 3, 2, 15, 30),
    ),
    Note(
      2,
      102,
      "Mật khẩu WiFi",
      "WiFi thư viện: Library_5G, mật khẩu: 987654321.",
      DateTime(2024, 2, 20, 9, 0),
      DateTime(2024, 2, 21, 10, 30),
      null,
      1, // Ghim lên đầu
    ),
    Note(
      3,
      103,
      "Danh sách mua sắm",
      "- Sữa\n- Bánh mì\n- Trứng\n- Nước cam",
      DateTime(2024, 3, 5, 18, 0),
      DateTime(2024, 3, 5, 19, 15),
    ),
    Note(
      4,
      104,
      "Thông tin tài khoản",
      "Ngân hàng ABC, số tài khoản: 1234567890.",
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
      "Chạy bộ: 6h - 6h30\nTập gym: 18h - 19h",
      DateTime(2024, 3, 10, 6, 0),
      DateTime(2024, 3, 10, 6, 30),
    ),
    Note(
      6,
      106,
      "Công thức món ăn",
      "Cách làm bánh pancake: trứng, sữa, bột mì, đường...",
      DateTime(2024, 2, 5, 15, 45),
      DateTime(2024, 2, 6, 16, 30),
      DateTime(2024, 3, 1), // Đã xóa
    ),
    Note(
      7,
      107,
      "Dự án lập trình",
      "Cần hoàn thành chức năng login trước thứ 4.",
      DateTime(2024, 3, 8, 13, 0),
      DateTime(2024, 3, 8, 17, 20),
    ),
    Note(
      8,
      108,
      "Danh sách việc cần làm",
      "- Hoàn thành báo cáo.\n- Nộp bài tập nhóm.\n- Đi họp phụ huynh.",
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

  // Tìm ghi chú theo ID
  // static Note? getNoteById(int id) {
  //   return notes.firstWhere((note) => note.noteId == id, orElse: () => null);
  // }

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
