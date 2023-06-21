import 'package:flutter/material.dart';

class StoreDetailPage extends StatelessWidget {
  const StoreDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Detail'),
      ),
      body: const Center(
        child: Text('Store Detail'),
      ),
    );
  }
}
