import 'package:notes_project/model/account.dart';

class AccountData {
 static List<Account> sampleAccounts = [
    Account("minhhien7840", "password123", "Nguyễn Văn A", 1),
    Account("user2@example.com", "12345678", "Trần Thị B", 2),
    Account("user3@example.com", "qwertyui", "Lê Văn C", 3),
    Account("user4@example.com", "letmein", "Phạm Thị D", 4),
    Account("user5@example.com", "passw0rd", "Hoàng Văn E", 5),
  ];

  // Phương thức đăng nhập
  static int? login(String email, String password) {
    for (var acc in sampleAccounts) {
      if (acc.email == email && acc.password == password) {
        return acc.accountId; // Trả về tài khoản nếu đúng email & password
      }
    }
    return null; // Trả về null nếu không tìm thấy tài khoản phù hợp
  }
   static Account? getAccount(int? id) {
    for (var acc in sampleAccounts) {
      if (acc.accountId == id ){
        return acc; // Trả về tài khoản nếu đúng email & password
      }
    }
    return null; // Trả về null nếu không tìm thấy tài khoản phù hợp
  }
  static bool isUsedEmail(String email) {
    for (var acc in sampleAccounts) {
      if (acc.email == email) {
        return true; 
      }
    }
    return false; // Trả về false nếu email chưa được sử dụng
  }
  static Account? createAccount(Account account) {
    if(isUsedEmail(account.email)){
      return null;
    }else {
      sampleAccounts.add(account);
    }
    return null;
  }

}
