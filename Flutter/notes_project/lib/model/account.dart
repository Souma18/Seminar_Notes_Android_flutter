class Account {
  int _accountId;
  String _username;
  String _password;
  String _phoneNumber;
  String _fullName;

  // Constructor
  Account(
    this._accountId,
    this._username,
    this._password,
    this._phoneNumber,
    this._fullName,
  );

  // Getter và Setter
  int get accountId => _accountId;
  set accountId(int id) => _accountId = id;

  String get username => _username;
  set username(String value) => _username = value;

  String get password => _password;
  set password(String value) => _password = value;

  String get phoneNumber => _phoneNumber;
  set phoneNumber(String value) => _phoneNumber = value;

  String get fullName => _fullName;
  set fullName(String value) => _fullName = value;
}
