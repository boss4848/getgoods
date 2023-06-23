import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';

class UserAddress extends StatelessWidget {
  const UserAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: double.infinity,
        height: 5,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
          image: DecorationImage(
            image: AssetImage('assets/images/envelope2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
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
                    color: primaryColor,
                  ),
                  Text(
                    ' Delivery Address',
                    style: TextStyle(
                      color: primaryColor,
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
                      color: Colors.black,
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
                      color: Colors.black,
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
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'SFTHONBURI',
                ),
              ),
              const Text(
                '9876 Willow Lane Apartment 345, Building C Sunset City, Eastwood County Meadowville, USA 12345',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'SFTHONBURI',
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
