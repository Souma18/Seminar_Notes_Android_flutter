import 'package:notes_project/model/Account.dart';

class AuthService {
  int login(String email, String password) {
    return 0;
  }

  Account? createAccount(Account account) {
    if(account.email == ""){
      return null;
    }else {
      
    }
    return null;
  }

  Account? getAccountById(int id) {
    return null;
  }
}
