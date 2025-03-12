class ConfigAccount {
  int _configId;
  int _accountId;
  String _theme;
  DateTime? _deleteDate;

  // Constructor với Named Parameters
  ConfigAccount(
    this._configId,
    this._accountId,
    this._theme, [
    DateTime? deleteDate,
  ]);

  // Getter & Setter
  int get configId => _configId;
  set configId(int id) => _configId = id;

  int get accountId => _accountId;
  set accountId(int id) => _accountId = id;

  String get theme => _theme;
  set theme(String value) => _theme = value;

  DateTime? get deleteDate => _deleteDate;
  set deleteDate(DateTime? date) => _deleteDate = date;
}
