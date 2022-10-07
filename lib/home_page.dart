import 'package:flutter/material.dart';
import 'item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController? _textEditingController = TextEditingController();
  List<Item> itemSearch = items;
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
                hintText: 'Search',
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none),
          ),
        ),
        actions: [
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.shopping_cart_rounded,
                color: Colors.white,
              ))
        ],
      ),
      body: ListView.builder(
          itemCount: itemSearch.length,
          itemBuilder: (context, idx) {
            return Products(
                image: itemSearch[idx].image,
                name: itemSearch[idx].name,
                price: itemSearch[idx].price,
                quantity: itemSearch[idx].quantity,
                vote: itemSearch[idx].vote);
          }),

      // body: GridView.count(
      //   mainAxisSpacing: 20,
      //   crossAxisSpacing: 10,
      //   crossAxisCount: 2,
      //   childAspectRatio: 0.8,
      //   children: <Widget>[
      //     Products(
      //         vote: 5,
      //         quantity: '2',
      //         price: 100000,
      //         image:
      //             'https://cdn2.cellphones.com.vn/358x/media/catalog/product/3/_/3_51_1_7.jpg',
      //         name: 'IPhone 13 Pro Max 128GB | Chính hãng VN/A'),
      //     Products(
      //         vote: 4,
      //         quantity: '2',
      //         price: 100000,
      //         image:
      //             'https://cdn2.cellphones.com.vn/358x/media/catalog/product/3/_/3_51_1_7.jpg',
      //         name: 'IPhone 13 Pro Max 128GB | Chính hãng VN/A'),
      //     Products(
      //         vote: 4,
      //         quantity: '2',
      //         price: 100000,
      //         image:
      //             'https://cdn2.cellphones.com.vn/358x/media/catalog/product/3/_/3_51_1_7.jpg',
      //         name: 'IPhone 13 Pro Max 128GB | Chính hãng VN/A'),
      //     Products(
      //         vote: 4,
      //         quantity: '2',
      //         price: 100000,
      //         image:
      //             'https://cdn2.cellphones.com.vn/358x/media/catalog/product/3/_/3_51_1_7.jpg',
      //         name: 'IPhone 13 Pro Max 128GB | Chính hãng VN/A'),
      //     Products(
      //         vote: 4,
      //         quantity: '2',
      //         price: 100000,
      //         image:
      //             'https://cdn2.cellphones.com.vn/358x/media/catalog/product/3/_/3_51_1_7.jpg',
      //         name: 'IPhone 13 Pro Max 128GB | Chính hãng VN/A'),
      //     Products(
      //         vote: 4,
      //         quantity: '2',
      //         price: 100000,
      //         image:
      //             'https://cdn2.cellphones.com.vn/358x/media/catalog/product/3/_/3_51_1_7.jpg',
      //         name: 'IPhone 13 Pro Max 128GB | Chính hãng VN/A'),

      //   ],
      // ),
    );
  }

  // ham search
  void search(String query) {
    final suggestions = items.where((item) {
      final title = item.name.toLowerCase();
      final input = query.toLowerCase();
      return title.contains(input);
    }).toList();
    setState(
      () => itemSearch = suggestions,
    );
    print(itemSearch);
  }
}

class Products extends StatelessWidget {
  Products({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.vote,
  });
  String image;
  String name;
  int price;
  String quantity;
  int vote;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(color: Colors.black38, blurRadius: 5)]),
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
              style: TextStyle(
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
                      return Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.yellow,
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 30,
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
