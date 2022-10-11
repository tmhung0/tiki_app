// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'item.dart';
import 'package:tiki_app/product_details.dart';

class Products extends StatelessWidget {
  Products(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      required this.quantity,
      required this.vote,
      required this.item});
  String image;
  String name;
  int price;
  String quantity;
  int vote;
  Item item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetails(item: item)));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 2)]),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 100,
                child: Image(image: NetworkImage(image)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                name,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              '$price đ',
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
            ),
            Row(
              children: [
                SizedBox(
                  width: 75,
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: vote,
                    itemBuilder: (context, idx) {
                      return const Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.yellow,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text('Đã bán: $quantity')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
