import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String name;
  final bool isRequired;
  final TextEditingController controller;
  final bool isUnderline;

  const InputField({
    super.key,
    required this.name,
    required this.isRequired,
    required this.controller,
    this.isUnderline = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: name + (isRequired ? ' *' : ''),
        labelStyle: const TextStyle(
          color: Colors.black54,
          fontSize: 16,
        ),

        //only add border buttom
        enabledBorder: isUnderline
            ? const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              )
            : InputBorder.none,
        focusedBorder: isUnderline
            ? const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              )
            : InputBorder.none,
        border: InputBorder.none,
      ),
    );
  }
}
