import 'package:flutter/material.dart';
import 'package:notes_project/presentation/screen/login/forgot_screen.dart';
import 'package:notes_project/presentation/screen/login/login_screen.dart';
import 'package:notes_project/presentation/screen/login/register_screen.dart';

import 'app_routes.dart';

class AppPages {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  Scaffold(body: Center(child: Text('Không tìm thấy trang'))),
        );
    }
  }
}
