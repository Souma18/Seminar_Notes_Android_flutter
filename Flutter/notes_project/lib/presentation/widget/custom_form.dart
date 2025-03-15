import 'package:flutter/material.dart';
import 'package:notes_project/presentation/widget/title_screen.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    required this.title,
    required this.inputs,
    required this.buttonText,
    required this.onPressed,
    this.icon,
    this.optional,
    this.formPadding = const EdgeInsets.all(24.0),
  });

  final String title;
  final List<Widget> inputs;
  final String buttonText;
  final VoidCallback onPressed;
  final Widget? icon;
  final Widget? optional;
  final EdgeInsetsGeometry formPadding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: formPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            if (icon != null)
              Center(child: icon!)
            else
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.account_box,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            const SizedBox(height: 32),
            TitleScreen(title: title),
            for (var input in inputs) ...[const SizedBox(height: 24), input],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8,
                  shadowColor: Colors.blue.withValues(alpha: 0.5),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            if (optional != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: optional!,
              ),
          ],
        ),
      ),
    );
  }
}
