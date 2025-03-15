import 'package:flutter/material.dart';
import 'package:notes_project/presentation/widget/custom_form.dart';
import 'package:notes_project/presentation/widget/custom_input.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    // Input fields - chỉ cần nhập email để khôi phục mật khẩu
    final List<Widget> inputs = [
      CustomInputText(controller: emailController, hintText: "Email",icon: Icons.email,),
    ];

    // Optional content
    final Widget forgotOptional = Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Quay lại đăng nhập",
              style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ),
        ],
      ),
    );

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
            title: "Quên mật khẩu",
            inputs: inputs,
            buttonText: "Gửi link khôi phục",
            onPressed: () {
              // Handle forgot password
            },
            icon: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lock_reset,
                size: 40,
                color: Colors.white,
              ),
            ),
            optional: forgotOptional,
          ),
        ),
      ),
    );
  }
}
