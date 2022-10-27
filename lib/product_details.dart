import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_app/cart.dart';
import 'package:tiki_app/provider/provider_cart.dart';

import 'item.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.item});
  final Item item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Chi tiết sản phẩm'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(alignment: Alignment.topRight, children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Carts()));
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
                        child: Center(
                            child: Text(cart.cartList.length.toString())));
                  },
                )
              ]),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  width: 400,
                  height: 200,
                  child: Image(image: NetworkImage(item.thumbnail.toString()))),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  item.title.toString(),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 75,
                      height: 20,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, idx) {
                          return const Icon(
                            Icons.star,
                            size: 15,
                            color: Colors.yellow,
                          );
                        },
                      ),
                    ),
                    Text('(${item.stock})'),
                    const SizedBox(
                      width: 20,
                    ),
                    // Text('Đã bán: ${item.sold}')
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    '${item.price} đ',
                    style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
              ),
              Consumer<CartProvider>(
                builder: (context, cart, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 30),
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          cart.addItemToCart(
                              item.id.toString(),
                              item.title.toString(),
                              item.thumbnail.toString(),
                              item.price!);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Carts()));
                        },
                        child: const Text('Mua ngay '),
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ));
  }
}
