import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, -1),
            blurRadius: 10,
          ),
        ],
        // color: Colors.green,
      ),
      child: Row(
        children: [
          Container(
            height: 80,
            color: primaryBGColor,
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(width: 10),
                // Checkbox(value: value, onChanged: onChanged),
                Text(
                  'Select All',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 80,
              color: primaryColor,
              child: const Center(
                child: Text(
                  'Check Out',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SelectAllButton extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onPressed;

  const SelectAllButton({
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 80,
        width: 200,
        color: isSelected ? Colors.green : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (value) => onPressed(),
            ),
            const SizedBox(width: 10),
            Text(
              'Select All',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
