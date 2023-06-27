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
  final String _selectedSortOption = 'Most Relevant';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
            width: double.infinity,
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
                          child: _buildCategorySelector(widget.filterProduct),
                        ),
                      )
                    : null,
              ),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          const Divider(thickness: 1.5),
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
        height: 35,
        width: 110,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(5),
          color: primaryColor,
        ),
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
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
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
        return Container(
          child: Column(
            children: [
              _buildCategoryItem('Processed', filterProduct),
              _buildCategoryItem('OTOP', filterProduct),
              _buildCategoryItem('Medicinal Plant', filterProduct),
              _buildCategoryItem('Dried Good', filterProduct),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryItem(String category, Function filterProduct) {
    String formattedCategory = category.toLowerCase().replaceAll(' ', '');
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

    return InkWell(
      // onTap: () {
      //   setState(() {
      //     _selectedCategory = formattedCategory;
      //     _isCategorySelectorVisible = false;
      //     print(
      //         'Category clicked: $formattedCategory');
      //   });
      // },
      onTap: () => filterProduct(convertToCamelCase(category)),
      child: Container(
        height: 40,
        child: ListTile(
          title: Text(
            category,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color:
                  _selectedCategory == formattedCategory ? primaryColor : null,
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
            fontSize: 12,
            color: primaryColor,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
