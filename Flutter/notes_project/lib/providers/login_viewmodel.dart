import 'package:flutter/material.dart';
import 'package:notes_project/service/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  String? errorMessage;

  void login(BuildContext context) {
    int result = _authService.login(emailController.text, passwordController.text);
    if (result != 0) {
      Navigator.pushNamed(context, '/home');
    } else {
      errorMessage = "Đăng nhập thất bại";
      notifyListeners(); 
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
