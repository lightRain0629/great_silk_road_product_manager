import 'package:flutter/material.dart';

class PassField extends StatefulWidget {
  final passwordController;

  const PassField({super.key, required this.passwordController});


  @override
  State<PassField> createState() => _PassFieldState();
}

bool _obscureText = true;

// String? _password;


class _PassFieldState extends State<PassField> {
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      obscureText: _obscureText,
      decoration: InputDecoration(
          labelText: 'Password',
          suffix: IconButton(
              onPressed: _toggle,
              icon: _obscureText? Icon(Icons.lock_open) : Icon(Icons.lock_outlined))),
    );
  }
}
