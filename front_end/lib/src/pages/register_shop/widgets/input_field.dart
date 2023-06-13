import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';

class InputField extends StatelessWidget {
  final String name;
  final bool isRequired;
  final TextEditingController controller;

  const InputField({
    super.key,
    required this.name,
    required this.isRequired,
    required this.controller,
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
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black54,
          ),
        ),
        border: InputBorder.none,
      ),
    );
  }
}
