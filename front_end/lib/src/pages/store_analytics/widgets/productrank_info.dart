import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/constants/constants.dart';

class ProductRankInfo extends StatefulWidget {
  @override
  _ProductRankInfoState createState() => _ProductRankInfoState();
}

class _ProductRankInfoState extends State<ProductRankInfo> {
  String selectedRank = '';
  final productRank = {
    'Revenue (Baht)': [
      {'name': 'Song 1 - Rock', 'unit': 300},
      {'name': 'Song 2 - Rock', 'unit': 200},
      {'name': 'Song 3 - Rock', 'unit': 100},
    ],
    'Visitors (Visitors)': [
      {'name': 'Song 1 - Jazz', 'unit': 30},
      {'name': 'Song 2 - Jazz', 'unit': 20},
      {'name': 'Song 3 - Jazz', 'unit': 10},
    ],
    'Unit Sold (Units)': [
      {'name': 'Song 1 - Pop', 'unit': 0.89},
      {'name': 'Song 2 - Pop', 'unit': 0.69},
      {'name': 'Song 3 - Pop', 'unit': 1.99},
    ],
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
      //List<String> productLists = productRank[selectedRank]!;
      return Expanded(
        child: ListView.builder(
          itemCount: productRank[selectedRank]!.length,
          itemBuilder: (context, index) {
            final productLists = productRank[selectedRank]![index];
            if (index < 3) {
              return ListTile(
                leading: _buildMedalIcon(index),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      productLists['name'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SFTHONBURI',
                      ),
                    ),
                    Text(productLists['unit'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'SFTHONBURI',
                        )),
                  ],
                ),
                //subtitle: Text('\$${productLists['price']}'),
              );
            } else {
              return ListTile(
                title: Text(
                  productLists['name'].toString(),
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
        iconData = Icons.filter_vintage_rounded;
        color = Colors.amber; // Customize the color for gold medal
        break;
      case 1:
        iconData = Icons.filter_vintage_rounded;
        color = Colors.grey; // Customize the color for silver medal
        break;
      case 2:
        iconData = Icons.filter_vintage_rounded;
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
      size: 30,
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
