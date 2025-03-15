import 'package:flutter/material.dart';
import 'package:notes_project/model/Account.dart';
import 'package:notes_project/service/auth_service.dart';

class RegisterViewmodel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? errorMessage;
  void register(BuildContext context) {
    if (passwordController.text != confirmPasswordController.text) {
      errorMessage = "Mật khẩu không khớp";
      notifyListeners();
    } else {
      final result = _authService.createAccount(
        Account(
          nameController.text,
          emailController.text,
          passwordController.text,
        ),
      );
      if (result != null) {
        Navigator.pushNamed(context, '/login');
      } else {
        errorMessage = "Email đã tồn tại";
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
