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
  String _selectedSortOption =
      'Most Relevant'; // Default selected sorting option

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutQuad,
                height: _isCategorySelectorVisible ? 200 : 0,
                child: _isCategorySelectorVisible
                    ? ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: _buildCategorySelector(),
                        ),
                      )
                    : null,
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(thickness: 1.5),
            ],
          ),
        ),
      ],
    );
  }

  Widget _filter() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isCategorySelectorVisible = !_isCategorySelectorVisible;
          if (_isCategorySelectorVisible) {
            Future.delayed(const Duration(milliseconds: 300)).then((_) {
              setState(() {
                // Additional state changes after the delay
              });
            });
          } else {
            // Additional state changes when hiding the category selector
          }
        });
      },
      child: Container(
        height: 48,
        width: 160,
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
            ),
            const SizedBox(width: 5),
            Text(
              _selectedCategory.isNotEmpty ? _selectedCategory : 'Category',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sorting() {
    return SizedBox(
      height: 48,
      child: PopupMenuButton<String>(
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          const PopupMenuItem<String>(
            value: 'Most Relevant',
            child: Text('Most Relevant'),
          ),
          const PopupMenuItem<String>(
            value: 'Most Reviewed',
            child: Text('Most Reviewed'),
          ),
          const PopupMenuItem<String>(
            value: 'Highest Rated',
            child: Text('Highest Rated'),
          ),
          const PopupMenuItem<String>(
            value: 'Newest',
            child: Text('Newest'),
          ),
        ],
        onSelected: (String value) {
          setState(() {
            _selectedSortOption = value;
            // Perform sorting based on the selected option
          });
        },
        child: Container(
          width: 170,
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
                    const Text(
                      'Sort by',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      _selectedSortOption,
                      style: const TextStyle(
                        fontSize: 18,
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

  Widget _buildCategorySelector() {
    return SizedBox(
      height: 200,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildCategoryItem('Processed'),
            _buildCategoryItem('OTOP'),
            _buildCategoryItem('Medicinal Plant'),
            _buildCategoryItem('Dried Food'),
          ],
        ),
      ),
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
      child: ListTile(
        title: Text(
          category,
          style: TextStyle(
            color: _selectedCategory == category ? primaryColor : null,
          ),
        ),
      ),
    );
  }

  Widget _clear() {
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: const Text('Clear'),
      ),
    );
  }

  // Widget _buildHeader() => Container(
  //       color: Colors.white,
  //       padding: const EdgeInsets.all(12),
  //       child: const Text(
  //         "Filter your products",
  //         style: TextStyle(
  //           color: primaryColor,
  //           fontWeight: FontWeight.bold,
  //           fontSize: 20,
  //         ),
  //       ),
  //     );
}
