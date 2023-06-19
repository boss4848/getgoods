import 'package:flutter/material.dart';
import 'package:getgoods/src/pages/review/widgets/review.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Review Page',
        home: Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.green,
              actions: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () {
                    //Navigator.pop(context);
                  },
                )
              ],
              title: const Text(
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'SFTHONBURI'),
                  'Product Review')),
              body: const Review()
              ),
        );
  }
}
