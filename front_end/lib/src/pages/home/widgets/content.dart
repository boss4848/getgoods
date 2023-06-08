import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'coupon.dart';
import 'banner_slider.dart';
import 'product_load_more.dart';

class Content extends StatefulWidget {
  const Content(this.scrollController, {super.key});

  final TrackingScrollController scrollController;

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
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
      onRefresh: () => Future.delayed(const Duration(seconds: 2)),
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
            const BannerSlider(),
            // _buildDivider(),
            const Coupon(),
            _buildDivider(),
            const ProductLoadMore(),
          ],
        ),
      ),
    );
  }

  Container _buildDivider() => Container(
        height: 8,
        color: Colors.grey[200],
      );
}
