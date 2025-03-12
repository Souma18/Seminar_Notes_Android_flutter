class Note {
  int _noteId;
  int _accountId;
  String _title;
  String _content;
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
    this._content,
    this._createAt,
    this._updateAt, [
    this._deleteAt,
    this._pinIndex,
    this._passNote, // Optional
  ]);

  // Getter & Setter
  int get noteId => _noteId;
  set noteId(int id) => _noteId = id;

  int get accountId => _accountId;
  set accountId(int id) => _accountId = id;

  String get title => _title;
  set title(String value) => _title = value;

  String get content => _content;
  set content(String value) => _content = value;

  int? get pinIndex => _pinIndex;
  set pinIndex(int? value) => _pinIndex = value;

  String? get passNote => _passNote;
  set passNote(String? value) => _passNote = value;

  DateTime get createAt => _createAt;
  set createAt(DateTime date) => _createAt = date;

  DateTime get updateAt => _updateAt;
  set updateAt(DateTime date) => _updateAt = date;

  DateTime? get deleteAt => _deleteAt;
  set deleteAt(DateTime? date) => _deleteAt = date;
}
