import 'package:flutter/material.dart';

class CustomFaltButton extends StatelessWidget {

  final String text;
  final void Function()? onPressed;
  const CustomFaltButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onPressed, child: Text(text));
  }
}