import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tiki_app/provider/provider_cart.dart';

class Carts extends StatelessWidget {
  const Carts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Giỏ hàng")),
        body: Consumer<CartProvider>(
          builder: (context, cart, child) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Tất cả (${cart.cartList.length} sản phẩm) ',
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                            width: 100,
                            height: 80,
                            image: NetworkImage(cart.cartList[index].image)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                cart.cartList[index].name,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                '${cart.cartList[index].price} đ',
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(style: BorderStyle.solid),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          cart.sub(cart.cartList[index]);
                                        },
                                        icon: const Icon(Icons.remove_outlined),
                                      ),
                                      Text(cart.cartList[index].quantity
                                          .toString()),
                                      IconButton(
                                          onPressed: () {
                                            cart.add(cart.cartList[index]);
                                          },
                                          icon: const Icon(Icons.add)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                cart.removeItem(cart.cartList[index].id);
                              },
                              child: const Text('Xóa')),
                        ),
                      ],
                    ),
                  );
                }, childCount: cart.cartList.length)),
              ],
            );
          },
        ),
        bottomNavigationBar: Consumer<CartProvider>(
          builder: (context, cart, child) {
            return BottomAppBar(
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                height: 80,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Tổng cộng',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          '${cart.getCartTotal()} đ',
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: cart.cartList.isEmpty
                                      ? const Text('Giỏ hàng trống')
                                      : const Text('Đặt hàng thành công'),
                                ));
                        cart.clearCart();
                      },
                      // ignore: sort_child_properties_last
                      child: Text(
                        'Mua (${cart.cartList.length})',
                        style: const TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          fixedSize: const Size(170, 50)),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
