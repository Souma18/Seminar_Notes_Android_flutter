import 'dart:convert';

class Note {
  int _noteId;
  int _accountId;
  String _title;
  String _contentJson; // Dữ liệu lưu dưới dạng JSON String
  int? _pinIndex;
  String? _passNote;
  DateTime _createAt;
  DateTime _updateAt;
  DateTime? _deleteAt;

  // Constructor
  Note(
      this._noteId,
      this._accountId,
      this._title,
      this._contentJson, // Lưu JSON string
      this._createAt,
      this._updateAt, [
        this._deleteAt,
        this._pinIndex,
        this._passNote,
      ]);

  // Getter & Setter
  int get noteId => _noteId;
  set noteId(int id) => _noteId = id;

  int get accountId => _accountId;
  set accountId(int id) => _accountId = id;

  String get title => _title;
  set title(String value) => _title = value;

  List<Map<String, dynamic>> get content {
    if (_contentJson.isNotEmpty) {
      try {
        var decoded = jsonDecode(_contentJson);
        if (decoded is List) {
          return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
        }
      } catch (e) {
        print("Lỗi decode JSON: $e");
      }
    }
    return [];
  }

  String? get passNote => _passNote;
  set passNote(String? value) => _passNote = value;

  /// ✅ **Chuyển List<Map<String, dynamic>> thành JSON khi gán dữ liệu**
  set content(List<Map<String, dynamic>> value) {
    _contentJson = jsonEncode(value);
  }
  int? get pinIndex => _pinIndex;
  set pinIndex(int? value) => _pinIndex = value;

  DateTime get createAt => _createAt;
  set createAt(DateTime date) => _createAt = date;

  DateTime get updateAt => _updateAt;
  set updateAt(DateTime date) => _updateAt = date;

  DateTime? get deleteAt => _deleteAt;
  set deleteAt(DateTime? date) => _deleteAt = date;

  // Copy với JSON content
  Note copyWith({
    int? noteId,
    int? accountId,
    String? title,
    List<Map<String, dynamic>>? content, // Nhận vào List<Map>
    int? pinIndex,
    String? passNote,
    DateTime? createAt,
    DateTime? updateAt,
    DateTime? deleteAt,
  }) {
    return Note(
      noteId ?? _noteId,
      accountId ?? _accountId,
      title ?? _title,
      jsonEncode(content ?? this.content), // Chuyển thành JSON String
      createAt ?? _createAt,
      updateAt ?? _updateAt,
      deleteAt ?? _deleteAt,
      pinIndex ?? _pinIndex,
      passNote ?? _passNote,
    );
  }
}