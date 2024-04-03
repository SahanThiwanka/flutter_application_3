// product_detail_page.dart

import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Extract image URLs from product['images'] and convert them to strings
    List<String> imageUrls = (product['images'] ?? []).map<String>((image) => image.toString()).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: ListView(
        children: [
          // Display ratings
          ListTile(
            title: Text('Ratings: ${product['ratings'] ?? 'N/A'}'),
          ),
          // Display price
          ListTile(
            title: Text('Price: \$${product['price'] ?? 'N/A'}'),
          ),
          // Display description
          ListTile(
            title: Text('Description: ${product['description'] ?? 'N/A'}'),
          ),
          // Display image slider
          ImageSlider(images: imageUrls), // Pass the list of strings
        ],
      ),
    );
  }
}


class ImageSlider extends StatelessWidget {
  final List<String> images;

  const ImageSlider({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(images[index]),
          );
        },
      ),
    );
  }
}
