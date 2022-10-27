// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'item.dart';
import 'package:tiki_app/product_details.dart';

class ComponentProduct extends StatelessWidget {
  ComponentProduct({super.key, required this.item});

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
                child: Image(image: NetworkImage(item.thumbnail.toString())),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                item.title.toString(),
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              '${item.price} đ',
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
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Đã bán: ${item.stock.toString()}',
                  style: const TextStyle(fontSize: 10),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
