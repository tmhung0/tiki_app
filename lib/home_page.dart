// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'item.dart';
import 'products.dart';
import 'provider/provider_cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  List<Item> itemSearch = items;

  // ham search
  void search(String query) {
    final suggestions = items.where((item) {
      final name = item.name.toLowerCase();
      final input = query.toLowerCase();
      return name.contains(input);
    }).toList();
    setState(
      () => itemSearch = suggestions,
    );
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
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_cart_rounded,
                    color: Colors.white,
                  )),
              Consumer<Cart>(
                builder: (context, cart, child) {
                  return Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Text(cart.count.toString())));
                },
              )
            ]),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: itemSearch.length,
          itemBuilder: (context, idx) {
            return Products(
              image: itemSearch[idx].image,
              name: itemSearch[idx].name,
              price: itemSearch[idx].price,
              quantity: itemSearch[idx].quantity,
              vote: itemSearch[idx].vote,
              item: itemSearch[idx],
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
