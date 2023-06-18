import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';

class ProductRankInfo extends StatefulWidget {
  @override
  _ProductRankInfoState createState() => _ProductRankInfoState();
}

class _ProductRankInfoState extends State<ProductRankInfo> {
  String selectedRank = '';
  Map<String, List<String>> productRank = {
    'Revenue (Baht)': ['Product1 - 250', 'Product2 - 200', 'Product3 - 150'],
    'Visitors (Visitors)': [
      'Product1 - 1258',
      'Product2 - 1035',
      'Product3 - 755'
    ],
    'Unit Sold (Units)': ['Product1 - 100', 'Product2 - 70', 'Product3 - 50'],
  };

  Widget _buildRankDropdown() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButton<String>(
        dropdownColor: secondaryColor,
        value: selectedRank.isEmpty ? null : selectedRank,
        hint: const Text(
          'Select a sort type',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'SFTHONBURI',
          ),
        ),
        onChanged: (String? newValue) {
          setState(() {
            selectedRank = newValue!;
          });
        },
        items: productRank.keys.map<DropdownMenuItem<String>>(
          (String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'SFTHONBURI',
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildProductList() {
    if (selectedRank.isEmpty) {
      return Container();
    } else {
      List<String> productLists = productRank[selectedRank]!;
      return Expanded(
        child: ListView.builder(
          itemCount: productLists.length,
          itemBuilder: (context, index) {
            if (index < 3) {
              return ListTile(
                leading: _buildMedalIcon(index),
                title: Text(
                  productLists[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
              );
            } else {
              return ListTile(
                title: Text(
                  productLists[index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
              );
            }
          },
        ),
      );
    }
  }

  Widget _buildMedalIcon(int index) {
    IconData iconData;
    Color color;

    switch (index) {
      case 0:
        iconData = Icons.circle;
        color = Colors.amber; // Customize the color for gold medal
        break;
      case 1:
        iconData = Icons.circle;
        color = Colors.grey; // Customize the color for silver medal
        break;
      case 2:
        iconData = Icons.circle;
        color = Colors.brown; // Customize the color for bronze medal
        break;
      default:
        iconData = Icons.circle_outlined; // or any other default icon
        color = Colors.black; // Customize the color for other medals
        break;
    }

    return Icon(
      iconData,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(defaultpadding),
      ),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: defaultpadding),
            child: Row(
              children: [
                const Text(
                  'Ranking BY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SFTHONBURI',
                  ),
                ),
                _buildRankDropdown(),
              ],
            ),
          ),
          _buildProductList(),
        ],
      ),
    );
  }
}
