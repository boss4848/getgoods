import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';

class ProductFilter extends StatefulWidget {
  final Function filterProduct;
  const ProductFilter({Key? key, required this.filterProduct})
      : super(key: key);

  @override
  State<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends State<ProductFilter> {
  bool _isCategorySelectorVisible = false;
  String _selectedCategory = '';
  final String _selectedSortOption =
      'Most Relevant'; // Default selected sorting option

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.yellow,
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            // color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _filter(),
                const SizedBox(
                  width: 10,
                ),
                _sorting(),
                const Spacer(),
                _clear(),
              ],
            ),
          ),
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutQuad,
                height: _isCategorySelectorVisible ? 160 : 0,
                child: _isCategorySelectorVisible
                    ? ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: _buildCategorySelector(),
                        ),
                      )
                    : null,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(thickness: 1.5),
        ],
      ),
    );
  }

  Widget _filter() {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            _isCategorySelectorVisible = !_isCategorySelectorVisible;
            // if (_isCategorySelectorVisible) {
            //   Future.delayed(const Duration(milliseconds: 500)).then((_) {
            //     setState(() {
            //       // Additional state changes after the delay
            //     });
            //   });
            // } else {
            //   // Additional state changes when hiding the category selector
            // }
          },
        );
      },
      child: Container(
        height: 35,
        width: 110,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(5),
            color: primaryColor),
        child: Row(
          children: [
            const Icon(
              Icons.filter_list,
              color: Colors.white,
              size: 10,
            ),
            const SizedBox(width: 5),
            Text(
              _selectedCategory.isNotEmpty ? _selectedCategory : 'Category',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 300)),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(); // Return an empty container while waiting
        }
        return Container(
          // color: Colors.yellow,
          child: Column(
            children: [
              _buildCategoryItem('Processed'),
              _buildCategoryItem('OTOP'),
              _buildCategoryItem('Medicinal Plant'),
              _buildCategoryItem('Dried Food'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryItem(String category) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategory = category;
          _isCategorySelectorVisible = false; // Close the category selector
        });
      },
      child: Container(
        // color: Colors.red,
        height: 40,
        child: ListTile(
          title: Text(
            category,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: _selectedCategory == category ? primaryColor : null,
            ),
          ),
        ),
      ),
    );
  }

  Widget _sorting() {
    return SizedBox(
      height: 35,
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

        // onSelected: (String value) {
        //   setState(() {
        //     _selectedSortOption = value;
        //     // Perform sorting based on the selected option
        //   });
        // },

        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: (BorderRadius.circular(5)),
              color: primaryColor),
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
                            color: Colors.white),
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

  Widget _clear() {
    return Flexible(
      child: Container(
        width: double.infinity,
        alignment: Alignment.bottomRight,
        child: const Text(
          'Set to default',
          maxLines: 2,
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 10,
            color: primaryColor,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
