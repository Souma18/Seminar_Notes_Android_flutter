import 'package:flutter/material.dart';

class CustomInputText extends StatefulWidget {
  const CustomInputText({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? icon;
  @override
  State<CustomInputText> createState() => _CustomInputTextState();
}

class _CustomInputTextState extends State<CustomInputText> {
  late bool _isObscured;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow:
              _isFocused
                  ? [
                    BoxShadow(
                      color: Colors.lightBlue.shade100,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : null,
        ),
        child: TextField(
          controller: widget.controller,
          obscureText: _isObscured,
          style: const TextStyle(color: Colors.black, fontSize: 16),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(
              widget.obscureText
                  ? Icons.lock_outline
                  : (widget.icon ?? Icons.person_outline),
              color: _isFocused ? Colors.black : Colors.grey[400],
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[800]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.lightBlue, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
            suffixIcon:
                widget.obscureText
                    ? IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility_off : Icons.visibility,
                        color:
                            _isFocused ? Colors.lightBlue : Colors.grey[400],
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    )
                    : null,
          ),
        ),
      ),
    );
  }
}
