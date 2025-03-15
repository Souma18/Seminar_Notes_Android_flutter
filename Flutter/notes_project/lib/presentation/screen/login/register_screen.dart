import 'package:flutter/material.dart';
import 'package:notes_project/presentation/widget/custom_form.dart';
import 'package:notes_project/presentation/widget/custom_input.dart';
import 'package:notes_project/providers/register_viewmodel.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    // Input fields
    final List<Widget> inputs = [
      CustomInputText(controller: nameController, hintText: "Họ và tên"),
      CustomInputText(
        controller: emailController,
        hintText: "Email",
        icon: Icons.email,
      ),
      CustomInputText(
        controller: passwordController,
        hintText: "Mật khẩu",
        obscureText: true,
      ),
      CustomInputText(
        controller: confirmPasswordController,
        hintText: "Xác nhận mật khẩu",
        obscureText: true,
      ),
    ];

    // Optional content
    final Widget registerOptional = Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Đã có tài khoản?", style: TextStyle(color: Colors.white)),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Đăng nhập",
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );

    return ChangeNotifierProvider(
      create: (context) => RegisterViewmodel(),
      child: Consumer<RegisterViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF02569B), Color(0xFF42A5F5)],
                ),
              ),
              child: SafeArea(
                child: CustomForm(
                  title: "Tạo tài khoản",

                  inputs: inputs,
                  buttonText: "Đăng ký",
                  onPressed: () {
                    // Handle registration
                  },
                  icon: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.app_registration,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  optional: registerOptional,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
