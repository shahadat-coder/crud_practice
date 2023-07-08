import 'dart:convert';
import 'dart:math';

import 'package:crud_test/product_list.dart';
import 'package:flutter/material.dart';

import 'add_new_product_screen.dart';
import 'package:http/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    Response response = await get(
        Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct"));

    final Map<String, dynamic> decodedrespons = jsonDecode(response.body);
    if (response.statusCode == 200 && decodedrespons['status'] == 'success') {
     for(var product in decodedrespons['data'] ){
       products.add(Product.toJson(product));
     }
    }
    print(products.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crud App'),
      ),
      body: ListView.separated(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      contentPadding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Choose an action"),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            onTap: () {},
                            leading: const Icon(Icons.edit),
                            title: const Text("Edit"),
                          ),
                          const Divider(
                            height: 1,
                          ),
                          ListTile(
                            onTap: () {},
                            leading: const Icon(Icons.delete),
                            title: const Text("Delete"),
                          ),
                        ],
                      ),
                    );
                  });
            },
            title: Text(products[index].productName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Product Code:${products[index].productCode}'),
                Text('Total Price:${products[index].totalPrice}'),
                Text('Avaiable unit:${products[index].quantity}'),
              ],
            ),
            leading: Image.network(
              products[index].image,
              errorBuilder: (_, __, ___) {
                return const Icon(
                  Icons.image,
                  size: 32,
                );
              },
              width: 60,
              height: 40,
              fit: BoxFit.cover,
            ),
            trailing: Text(products[index].totalPrice),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddNewProduct()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
