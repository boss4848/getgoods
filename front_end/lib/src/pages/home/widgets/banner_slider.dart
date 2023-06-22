import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: const [
        BannerSection(),
      ],
    );
  }
}

class BannerSection extends StatefulWidget {
  const BannerSection({super.key});

  @override
  State<BannerSection> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSection> {
  final List<String> _imageList = [
    "assets/images/banner_1.jpg",
    "assets/images/banner_2.jpg",
    "assets/images/banner_3.jpg",
    "assets/images/banner_4.jpg",
    "assets/images/banner_5.jpg",
    "assets/images/banner_6.jpg",
    "assets/images/banner_7.jpg",
    "assets/images/banner_8.jpg",
  ];

  late int _currentImageIndex;
  @override
  void initState() {
    _currentImageIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBanner(),
        _buildIndicator(),
      ],
    );
  }

  Container _buildBanner() => Container(
        width: double.infinity,
        // height: 300,
        // margin: const EdgeInsets.only(bottom: 65),
        child: CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 1.873,
            viewportFraction: 1.0,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _currentImageIndex = index;
              });
            },
          ),
          items: _imageList
              .map(
                (item) => Image.asset(
                  item,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
              .toList(),
        ),
      );
  int index = 0;
  Positioned _buildIndicator() {
    return Positioned(
      bottom: 10,
      left: 8,
      child: Row(
        children: _imageList.map((image) {
          if (index > 7) {
            index = 0;
          }
          index++;
          // print(index);
          return Container(
            width: 8,
            height: (_currentImageIndex + 1) == index ? 8 : 1,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: (_currentImageIndex + 1) == index
                  ? Colors.white
                  : Colors.grey.shade400,
              border: Border.all(color: Colors.white),
              shape: (_currentImageIndex + 1) == index
                  ? BoxShape.circle
                  : BoxShape.rectangle,
              // color: Colors.transparent,
            ),
          );
        }).toList(),
      ),
    );
  }
}
