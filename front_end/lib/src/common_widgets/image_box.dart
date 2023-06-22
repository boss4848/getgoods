import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  final String imageUrl;
  final double height;
  const ImageBox({
    super.key,
    required this.imageUrl,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        ),
        errorWidget: (context, url, error) {
          print(url);
          print(error);
          return const Center(
            child: Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 40,
            ),
          );
        },
      ),
    );
  }
}
