class Account {
  int? _accountId;
  String _email;
  String _password;
  String _fullName;

  // Constructor
  Account( this._email, this._password, this._fullName,[this._accountId]);
  // Getter và Setter
  int? get accountId => _accountId;
  set accountId(int? id) => _accountId = id;

  String get password => _password;
  set password(String value) => _password = value;

  String get email => _email;
  set email(String value) => _email = value;

  String get fullName => _fullName;
  set fullName(String value) => _fullName = value;
}
