// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_app/provider/provider_cart.dart';
import 'item.dart';
import 'component_products.dart';
import 'cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> listProducts = [];
  List<Item> searchItem = [];

  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<void> _fetchData() async {
    const apiUrl = 'https://mocki.io/v1/cdb94674-6db8-4339-bb48-1c68ce1be77b';
    final response = await http.get(Uri.parse(apiUrl));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Item> loadedProducts = [];
    extractedData["products"].forEach((itemData) {
      loadedProducts.add(
        Item(
            id: itemData['id'],
            name: itemData['name'],
            price: itemData['price'],
            image: itemData['image'],
            vote: itemData['vote'],
            quantity: itemData['quantity'],
            sold: itemData['sold']),
      );
    });
    setState(() => searchItem = listProducts = loadedProducts);
  }

  void search(String query) {
    final suggestions = listProducts.where((item) {
      final name = item.name.toString().toLowerCase();
      final input = query.toLowerCase();
      return name.contains(input);
    }).toList();
    setState(() => {searchItem = suggestions});
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  _getMoreData() {
    searchItem.addAll(test);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(3)),
          child: TextField(
            onChanged: search,
            controller: _textEditingController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                contentPadding: EdgeInsets.all(15),
                hintText: 'Tìm kiếm',
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(alignment: Alignment.topRight, children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Carts()));
                  },
                  icon: const Icon(
                    Icons.shopping_cart_rounded,
                    color: Colors.white,
                  )),
              Consumer<CartProvider>(
                builder: (context, cart, child) {
                  return Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child:
                          Center(child: Text(cart.myCartCount().toString())));
                },
              )
            ]),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          controller: _scrollController,
          itemCount: searchItem.length + 1,
          itemBuilder: (context, idx) {
            if (idx == searchItem.length) {
              return const CupertinoActivityIndicator();
            }
            return ComponentProduct(
              item: searchItem[idx],
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
        ),
      ),
    );
  }
}
