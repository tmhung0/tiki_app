import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_app/provider/provider_cart.dart';

class Carts extends StatelessWidget {
  const Carts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ hàng'),
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Tất cả (${cart.count.toString()} sản phẩm)',
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Consumer(
                builder: (context, value, child) {
                  return SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image(
                              width: 100,
                              height: 80,
                              image:
                                  NetworkImage(cart.basketitem[index].image)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 200,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  cart.basketitem[index].name,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  cart.basketitem[index].price.toString(),
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            style: BorderStyle.solid),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            cart.remote(cart.basketitem[index]);
                                          },
                                          icon:
                                              const Icon(Icons.remove_outlined),
                                        ),
                                        const Text('1'),
                                        IconButton(
                                            onPressed: () {
                                              cart.add(cart.basketitem[index]);
                                            },
                                            icon: const Icon(Icons.add)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              onPressed: () {
                                cart.remote(cart.basketitem[index]);
                              },
                              child: const Text('Xóa')),
                        ],
                      ),
                    );
                  }, childCount: cart.basketitem.length));
                },
              ),
              SliverToBoxAdapter(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text("Tổng cộng:"),
                      Text(
                        cart.totalPrice.toString(),
                        style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
                    ],
                  ),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: cart.basketitem.isEmpty
                                      ? const Text('Giỏ hàng trống')
                                      : const Text('Đặt hàng thành công'),
                                ));
                        cart.remoteAll();
                      },
                      child: Text('Mua hàng (${cart.basketitem.length})'))
                ],
              ))
            ],
          );
        },
      ),
    );
  }
}
