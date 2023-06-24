import 'package:flutter/material.dart';
import '../../../constants/colors.dart';

class CustomBar extends StatelessWidget {
  const CustomBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, -1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          SelectAllButton(), // Use the custom SelectAllButton widget
          const Expanded(
            child: CheckOutButton(),
          ),
        ],
      ),
    );
  }
}

class SelectAllButton extends StatefulWidget {
  @override
  _SelectAllButtonState createState() => _SelectAllButtonState();
}

class _SelectAllButtonState extends State<SelectAllButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        height: 80,
        width: 250,
        color: isSelected ? primaryBGColor : Colors.white,
        child: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        isSelected = value ?? false;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Select All',
                  style: TextStyle(
                    color: isSelected ? primaryColor : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                      '฿ 100'), //To show total price of all products that have been selected.
                  Text('Total'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 200,
      color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            'Check Out',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            ' (' '0' ') ',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ) //To show quantity of all products that have been selected
        ],
      ),
    );
  }
}
