import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            children: [
              _buildInputSearch(),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }

  _buildInputSearch() {
    const sizeIcon = BoxConstraints(
      minWidth: 40,
      minHeight: 40,
    );
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.transparent,
        width: 0,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(6),
      ),
    );
    return Expanded(
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0.2,
            blurRadius: 7,
            offset: const Offset(0, 1),
          )
        ]),
        child: const TextField(
          style: TextStyle(
            fontSize: 18,
            color: primaryColor,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(4),
            isDense: true,
            enabledBorder: border,
            focusedBorder: border,
            hintText: "Getgoods",
            hintStyle: TextStyle(
              fontSize: 18,
              color: primaryColor,
            ),
            prefixIcon: Icon(
              CupertinoIcons.search,
              color: primaryColor,
            ),
            prefixIconConstraints: sizeIcon,
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
