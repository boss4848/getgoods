import 'package:flutter/material.dart';
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
        description:
            "Dried Mango, Packaged in a convenient resealable pouch, it's the perfect healthy and delicious snack.",
        quantity: 2,
        price: 20.00,
        imageCover:
            "https://emilyfabulous.com/wp-content/uploads/2022/04/dried-mango-slices-in-a-bowl.jpg"),
    CartDetail(
        name: "Palm Dessert",
        description:
            "Dried Banana, With a satisfying chewy texture, they are perfect for a guilt-free snack. Encased in a convenient resealable package.",
        quantity: 3,
        price: 40.00,
        imageCover:
            "https://static.amarintv.com/images/upload/editor/source/Program/longpung-guide/guide7/kanhomtanbaansuwan/cover.jpg")
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: List.generate(
              cartDetail.length,
              (index) => ProductDetail(
                cartDetail: cartDetail[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductDetail extends StatefulWidget {
  final CartDetail cartDetail;
  const ProductDetail({super.key, required this.cartDetail});

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

  // @override
  // void initState() {
  //   super.initState();
  //   selectedQuantity = widget.cartDetail.quantity;
  // }

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
      padding: const EdgeInsets.only(left: 10),
      width: double.infinity,
      child: Row(
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
            margin: const EdgeInsets.all(15),
            child: Image.network(
              widget.cartDetail.imageCover,
              height: 150,
              width: 150,
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
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                width: 200,
                child: Text(
                  widget.cartDetail.description,
                  softWrap: true,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w800),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Text("Price : ${widget.cartDetail.price}" " Baht",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  )),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: decreaseQuantity,
                        ),
                        Text(selectedQuantity.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: increaseQuantity,
                        ),
                      ],
                    ),
                  ),
                  if (selectedQuantity >= widget.cartDetail.quantity)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        'Maximum Reached',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
