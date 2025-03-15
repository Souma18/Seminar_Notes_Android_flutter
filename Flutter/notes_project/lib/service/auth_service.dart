
import 'package:notes_project/database/account_data.dart';
import 'package:notes_project/model/account.dart';

class AuthService {
  int? login(String email, String password) {
    return AccountData.login(email, password);
  }

  Account? createAccount(Account account) {
    return AccountData.createAccount(account);
  }

  Account? getAccountById(int? id) {
    return AccountData.getAccount(id);
  }
}
