import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscuredText;
   const CustomTextField({super.key, required this.hintText, required this.obscuredText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscuredText,
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
             borderSide: BorderSide(
                 color: Theme.of(context).colorScheme.tertiary
             )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary
            )
          ),
          fillColor: Theme.of(context).colorScheme.secondary,
          filled: true
        ),
      ),
    );
  }
}
