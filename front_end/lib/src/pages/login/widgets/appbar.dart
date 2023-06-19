import 'package:flutter/material.dart';

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({Key? key, required this.titleName}) : super(key: key);

  final String titleName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                print("poppop");
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const LoginPage()),
                // );
              },
              child: Icon(
                Icons.chevron_left_rounded,
                size: 40,
                color: Colors.white,
              ),
            ),
            Text(
              titleName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
                fontFamily: 'SFTHONBURI',
              ),
            )
          ],
        ),
      ),
    );
  }
}
