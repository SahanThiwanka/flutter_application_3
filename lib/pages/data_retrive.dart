import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProducListPage extends StatefulWidget {
  const ProducListPage({Key? key}) : super(key: key);

  @override
  State<ProducListPage> createState() => _ProducListPageState();
}

class _ProducListPageState extends State<ProducListPage> {
  // Define a list to hold the products
  List<dynamic> products = [];

  // Function to fetch products from the API
Future<void> fetchProducts() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    final Map<String, dynamic> data = json.decode(response.body);
    final List<dynamic> productList = data['products']; // Assuming 'products' is the key for your list of products

    setState(() {
      products = productList;
    });
  } else {
    // If the server did not return a 200 OK response, throw an exception.
    throw Exception('Failed to load products');
  }
}

  @override
  void initState() {
    super.initState();
    // Call fetchProducts when the widget is first created
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Center(
        child: products.isEmpty
            ? CircularProgressIndicator() // Show a loading indicator if products are still being fetched
            : ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(products[index]['name'] ?? ''),
                    subtitle: Text('\$${products[index]['price'] ?? ''}'),
                    // Add more fields as needed
                  );
                },
              ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProducListPage(),
  ));
}
