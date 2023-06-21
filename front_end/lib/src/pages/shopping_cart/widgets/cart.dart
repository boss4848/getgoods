import 'package:flutter/material.dart';
import 'package:getgoods/src/constants/colors.dart';
import 'package:getgoods/src/models/cart_model.dart';

class ProductInCart extends StatefulWidget {
  const ProductInCart({Key? key}) : super(key: key);

  @override
  State<ProductInCart> createState() => _ProductInCartState();
}

class _ProductInCartState extends State<ProductInCart> {
  List<CartDetail> cartDetail = [
    CartDetail(
      name: 'Dried Mango',
      shop: 'Farm Suuk',
      description:
          "Dried Mango, Packaged in a convenient resealable pouch, it's the perfect healthy and delicious snack.",
      quantity: 30,
      price: 20.00,
      imageCover:
          "https://emilyfabulous.com/wp-content/uploads/2022/04/dried-mango-slices-in-a-bowl.jpg",
    ),
    CartDetail(
      name: "Palm Dessert",
      shop: 'Farm Tuuk',
      description:
          "Dried Banana, With a satisfying chewy texture, they are perfect for a guilt-free snack. Encased in a convenient resealable package.",
      quantity: 15,
      price: 40.00,
      imageCover:
          "https://static.amarintv.com/images/upload/editor/source/Program/longpung-guide/guide7/kanhomtanbaansuwan/cover.jpg",
    ),
    CartDetail(
      name: 'Dried Banana',
      shop: 'Farm Rak',
      description:
          "Dried Banana, With a satisfying chewy texture, they are perfect for a guilt-free snack. Encased in a convenient resealable package.",
      quantity: 10,
      price: 20.00,
      imageCover:
          "https://thehappierhomemaker.com/wp-content/uploads/2018/02/banana-chips-featured.jpg",
    ),
    CartDetail(
      name: "Rattan bag",
      shop: 'Louis Vitoo Shop',
      description:
          "Handcrafted synthetic rattan baskets gold fabric with white border. It's a handmade product. The work is extremely detailed.",
      quantity: 5,
      price: 40.00,
      imageCover:
          "https://lzd-img-global.slatic.net/g/p/f709ff72799d48fd0bd25648b0bc2d0e.jpg_360x360q75.jpg_.webp",
    ),
    CartDetail(
      name: 'Dried Mango',
      shop: 'Farm Suuk',
      description:
          "Dried Mango, Packaged in a convenient resealable pouch, it's the perfect healthy and delicious snack.",
      quantity: 30,
      price: 20.00,
      imageCover:
          "https://emilyfabulous.com/wp-content/uploads/2022/04/dried-mango-slices-in-a-bowl.jpg",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: _buildShopGroups(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildShopGroups() {
    Map<String, List<CartDetail>> shopGroups = {};

    // Group cart details by shop name
    for (var cart in cartDetail) {
      if (shopGroups.containsKey(cart.shop)) {
        shopGroups[cart.shop]!.add(cart);
      } else {
        shopGroups[cart.shop] = [cart];
      }
    }

    // Build shop groups
    List<Widget> shopGroupsWidgets = [];
    shopGroups.forEach((shop, cartList) {
      shopGroupsWidgets.add(
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  shop,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            const Divider(),
            Column(
              children: cartList.map((cart) {
                return ProductDetail(cartDetail: cart);
              }).toList(),
            ),
          ],
        ),
      );
    });

    return shopGroupsWidgets;
  }
}

class ProductDetail extends StatefulWidget {
  final CartDetail cartDetail;
  const ProductDetail({Key? key, required this.cartDetail}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int selectedQuantity = 0;
  bool isSelected = false;

  void updateSelectedStatus(int index, bool isSelected) {
    setState(() {
      isSelected = !isSelected;
    });
  }

  void increaseQuantity() {
    setState(() {
      if (selectedQuantity < widget.cartDetail.quantity) {
        selectedQuantity++;
      }
    });
  }

  void decreaseQuantity() {
    setState(() {
      if (selectedQuantity > 0) {
        selectedQuantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  isSelected = !isSelected;
                });
              },
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: grey),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.network(
                widget.cartDetail.imageCover,
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    widget.cartDetail.name,
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  width: 150,
                  child: Text(
                    widget.cartDetail.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                        fontSize: 8, fontWeight: FontWeight.w800),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Text(
                          "Price : ${widget.cartDetail.price}" " Baht",
                          style: const TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: SizedBox(
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              iconSize: 16,
                              onPressed: decreaseQuantity,
                            ),
                            Text(
                              selectedQuantity.toString(),
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              iconSize: 16,
                              onPressed: increaseQuantity,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (selectedQuantity >= widget.cartDetail.quantity)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                          'Maximum Reached',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.red,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
