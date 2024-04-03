import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_3/pages/product_detail_page.dart';

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
    final Map<String, dynamic> responseData = json.decode(response.body);

    // Check if the response contains the list of products
    if (responseData.containsKey('products')) {
      setState(() {
        products = responseData['products'];
      });
    } else {
      throw Exception('Products not found in response');
    }
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
    double width = MediaQuery.of(context).size.width;
    return 
     Container(
      height: MediaQuery.of(context).size.height * 0.65,
      width : width,
        child: products.isEmpty
            ? Column(
              children: [
                Container(child: CircularProgressIndicator(),width: 50,height: 50,),
              ],
            ) // Show a loading indicator if products are still being fetched
            : ListView.builder(
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = products[index];
                  return ListTile(
                    leading: product['thumbnailUrl'] != null
                        ? Image.network(product['thumbnailUrl'])
                        : SizedBox(), // Check for null and handle it
                    title: Text(product['title'] ?? 'No Title'),
                    subtitle: Text('\$${product['price'] ?? 'No Price'}'),
                    trailing: Text(product['brand'] ?? 'No Brand'),

                    onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: product),
                      ),
                    );
                  },

                  );
                },
              ),
    
    );
  }
}

