import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../constants/colors.dart';

class ProductSorting extends StatefulWidget {
  final Function sortProduct;
  final Function defaultProduct;
  const ProductSorting(
      {Key? key, required this.defaultProduct, required this.sortProduct})
      : super(key: key);

  @override
  State<ProductSorting> createState() => _ProductSortingState();
}

class _ProductSortingState extends State<ProductSorting> {
  final String _selectedSortOption = 'Most Relevant';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  width: 10,
                ),
                _sorting(),
                const Spacer(),
                _clear(widget.defaultProduct),
              ],
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          const Divider(thickness: 1.5),
        ],
      ),
    );
  }

  Widget _sorting() {
    return SizedBox(
      height: 40,
      width: 110,
      child: PopupMenuButton<String>(
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'Most Relevant',
            child: Text(
              'Most Relevant',
              style: TextStyle(fontSize: 10),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'Most Reviewed',
            child: Text(
              'Most Reviewed',
              style: TextStyle(fontSize: 10),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'Highest Rated',
            child: Text(
              'Highest Rated',
              style: TextStyle(fontSize: 10),
            ),
          ),
          const PopupMenuItem<String>(
            value: 'Newest',
            child: Text(
              'Newest',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
            color: primaryColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 2),
                      child: const Text(
                        'Sort by',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _selectedSortOption,
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _clear(Function defaultProduct) {
    return Flexible(
      child: Container(
        width: double.infinity,
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTap: () {
            defaultProduct();
          },
          child: const Text(
            'Set to default',
            maxLines: 2,
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 12,
              color: primaryColor,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
