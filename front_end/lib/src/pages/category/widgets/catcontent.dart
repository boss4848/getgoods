import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:getgoods/src/pages/category/widgets/product.dart';

import '../../../models/product_model.dart';
import '../../../viewmodels/product_viewmodel.dart';

class CatContent extends StatefulWidget {
  final List<Product> products;
  final ProductViewModel productViewModel;
  final Function onRefresh;
  const CatContent(
    this.scrollController, {
    super.key,
    required this.onRefresh,
    required this.products,
    required this.productViewModel,
  });

  final TrackingScrollController scrollController;

  @override
  State<CatContent> createState() => _CatContentState();
}

class _CatContentState extends State<CatContent> {
  final _indicatorController = IndicatorController();
  @override
  void dispose() {
    _indicatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      controller: _indicatorController,
      onRefresh: () => widget.onRefresh(),
      builder: (context, child, controller) => AnimatedBuilder(
        animation: controller,
        builder: (context, _) => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (!controller.isIdle)
              Positioned(
                top: 110 * controller.value,
                child: const SizedBox(
                  height: 40,
                  width: 40,
                  child: SpinKitSquareCircle(
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            Transform.translate(
              offset: Offset(0, 155.0 * controller.value),
              child: child,
            ),
          ],
        ),
      ),
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: Column(
          children: [
            ShowProduct(
              products: widget.products,
              productViewModel: widget.productViewModel,
            ),
          ],
        ),
      ),
    );
  }
}
