import 'package:flutter/material.dart';
import 'package:getgoods/src/viewmodels/product_viewmodel.dart';
import '../../models/product_model.dart';
import './widgets/header.dart';
import './widgets/content.dart';

class HomePage extends StatefulWidget {
  final Size size;
  final double paddingBottom;
  const HomePage(this.size, this.paddingBottom, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollControll = TrackingScrollController();
  late Offset _position;
  late double _dxMax;
  late double _dyMax;

  @override
  void initState() {
    _position = Offset.zero;
    _dxMax = widget.size.width - 100;
    _dyMax = widget.size.height - (160 + widget.paddingBottom);
    super.initState();
    _getProducts();
    products = productViewModel.products;
  }

  @override
  void dispose() {
    _scrollControll.dispose();
    super.dispose();
    _getProducts();
    products = productViewModel.products;
  }

  late ProductViewModel productViewModel = ProductViewModel();
  late List<Product> products;

  _getProducts() async {
    await productViewModel.fetchProducts();

    setState(() {
      products = productViewModel.products;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        children: [
          // Content(_scrollControll),
          Content(
            _scrollControll,
            onRefresh: () => _getProducts(),
            products: products,
            productViewModel: productViewModel,
          ),
          Header(
            scrollController: _scrollControll,
          ),
          Positioned(
            left: _position.dx > widget.size.width / 2 ? _dxMax : 0,
            top: _dyMax,
            child: Draggable(
              feedback: _buildDragFAB(),
              child: _buildDragFAB(),
              childWhenDragging: Container(),
              onDragEnd: (details) {
                setState(() {
                  _position = details.offset;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildDragFAB() => Stack(
        clipBehavior: Clip.none,
        children: [
          RawMaterialButton(
            onPressed: () {
              print("Print");
            },
            elevation: 4.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(8),
            shape: const CircleBorder(
              side: BorderSide(
                color: Colors.green,
              ),
            ),
            child: Image.asset(
              'assets/images/logo_2.png',
              width: 50,
              height: 50,
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 22,
              height: 22,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: const Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Positioned(
            right: 0,
            top: -10,
            child: SizedBox(
              width: 22,
              height: 22,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          )
        ],
      );
}
