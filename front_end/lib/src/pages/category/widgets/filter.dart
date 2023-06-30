import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';

class ProductFilter extends StatefulWidget {
  final Function filterProduct;
  final Function defaultProduct;
  const ProductFilter(
      {Key? key, required this.filterProduct, required this.defaultProduct})
      : super(key: key);

  @override
  State<ProductFilter> createState() => _ProductFilterState();
}

class _ProductFilterState extends State<ProductFilter> {
  bool _isCategorySelectorVisible = false;
  String _selectedCategory = '';
  String categoryItem = 'Category';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _filter(),
                  const Spacer(),
                  _clear(widget.defaultProduct),
                ],
              ),
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
                          child: _buildCategorySelector(widget.filterProduct),
                        ),
                      )
                    : null,
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          // const Divider(),
        ],
      ),
    );
  }

  Widget _filter() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isCategorySelectorVisible = !_isCategorySelectorVisible;
        });
      },
      child: Container(
        height: 40,
        // width: 120,
        //padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          // color: primaryColor,
        ),
        child: Row(
          children: [
            //const SizedBox(width: 5),
            Text(
              _selectedCategory.isNotEmpty ? _selectedCategory : categoryItem,
              style: const TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 3),
            const Icon(
              Icons.arrow_drop_down_sharp,
              color: primaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector(Function filterProduct) {
    return FutureBuilder(
      future: Future.delayed(const Duration(milliseconds: 300)),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }
        return Column(
          children: [
            _buildCategoryItem('Processed', filterProduct),
            _buildCategoryItem('OTOP', filterProduct),
            _buildCategoryItem('Medicinal Plant', filterProduct),
            _buildCategoryItem('Dried Good', filterProduct),
          ],
        );
      },
    );
  }

  Widget _buildCategoryItem(String category, Function filterProduct) {
    String convertToCamelCase(String text) {
      List<String> words = text.split(RegExp(r'\s+|_'));
      String camelCaseText = words[0].toLowerCase();
      for (int i = 1; i < words.length; i++) {
        String word = words[i];
        camelCaseText += word.substring(0, 1).toUpperCase() +
            word.substring(1).toLowerCase();
      }

      return camelCaseText;
    }

    bool isSelected = _selectedCategory == category; // Add this line

    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategory = category;
          _isCategorySelectorVisible = false;
        });
        filterProduct(convertToCamelCase(category));
      },
      child: SizedBox(
        height: 40,
        child: ListTile(
          title: Text(
            category,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isSelected ? primaryColor : primaryTextColor,
            ),
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
            setState(() {
              _selectedCategory = categoryItem;
            });
            defaultProduct();
          },
          child: const Text(
            'Set to default',
            maxLines: 2,
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 12,
              color: Colors.grey,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
