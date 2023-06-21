import 'package:flutter/material.dart';

class ProductFilter extends StatefulWidget {
  const ProductFilter({Key? key}) : super(key: key);

  @override
  State<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends State<ProductFilter> {
  bool _isCategorySelectorVisible = false;
  String _selectedSortOption = 'Rating'; // Default selected sorting option

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: _filter(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ],
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildSortingDropdown(),
                  ],
                ),
              ),
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
        ],
      ),
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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Row(
          children: const [
            Icon(Icons.category),
            SizedBox(width: 5),
            Text('Category'),
          ],
        ),
      ),
    );
  }

  Widget _buildSortingDropdown() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: const Text(
              'Sort by',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ),
          DropdownButton<String>(
            value: _selectedSortOption,
            onChanged: (String? newValue) {
              setState(() {
                _selectedSortOption = newValue!;
                // Perform sorting based on the selected option
              });
            },
            items: <String>['Rating', 'Price', 'Newest'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          _buildCategoryItem('Processed'),
          _buildCategoryItem('OTOP'),
          _buildCategoryItem('Medicinal Plant'),
          _buildCategoryItem('Dried Food'),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String category) {
    return ListTile(
      title: Text(category),
      onTap: () {
        setState(() {
          // Update the selected category
          // Do whatever you want with the selected category
          _isCategorySelectorVisible = false; // Close the category selector
        });
      },
    );
  }
}
