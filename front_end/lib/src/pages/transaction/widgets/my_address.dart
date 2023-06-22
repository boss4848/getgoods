import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';

class UserAddress extends StatelessWidget {
  const UserAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/envelope_background.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(defaultpadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                Text(
                  ' Delivery Address',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: defaultpadding,
            ),
            Row(
              children: const [
                Text(
                  'Firstname',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
                SizedBox(
                  width: defaultpadding / 4,
                ),
                Text(
                  'Lastname',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
              ],
            ),
            const Text(
              '0987654321',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w300,
                fontFamily: 'SFTHONBURI',
              ),
            ),
            const Text(
              '9876 Willow Lane Apartment 345, Building C Sunset City, Eastwood County Meadowville, USA 12345',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w300,
                fontFamily: 'SFTHONBURI',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
