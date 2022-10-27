// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiki_app/provider/provider_cart.dart';
import 'item.dart';
import 'component_products.dart';
import 'cart.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> listProducts = [];
  List<Item> searchItem = [];

  stt.SpeechToText? _speech;
  bool _isListening = false;
  bool _checkLoad = true;
  late List<Item> getData;
  late int numberLoadProduct = 0;

  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<void> _fetchData() async {
    const apiUrl = 'https://dummyjson.com/products?limit=40';
    final response = await http.get(Uri.parse(apiUrl));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Item> loadedProducts = [];
    extractedData["products"].forEach((itemData) {
      loadedProducts.add(
        Item(
          id: itemData['id'],
          title: itemData['title'],
          price: itemData['price'],
          thumbnail: itemData['thumbnail'],
          stock: itemData['stock'],
        ),
      );
    });
    setState(() {
      _checkLoad = true;
      searchItem = searchItem = loadedProducts;
    });
  }

  Future<void> searchData(String searchText) async {
    final apiUrl = 'https://dummyjson.com/products/search?q=$searchText';
    final response = await http.get(Uri.parse(apiUrl));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Item> searchDataItem = [];
    extractedData["products"].forEach((itemData) {
      searchDataItem.add(
        Item(
          id: itemData['id'],
          title: itemData['title'],
          price: itemData['price'],
          thumbnail: itemData['thumbnail'],
          stock: itemData['stock'],
        ),
      );
    });
    setState(() {
      if (searchText == '') {
        _fetchData();
        _checkLoad = true;
      } else {
        _checkLoad = false;
        searchItem = searchDataItem;
      }
    });
  }

  Future<void> getSperpage(int items) async {
    final apiUrl = 'https://dummyjson.com/products?limit=20&skip=$items';
    final response = await http.get(Uri.parse(apiUrl));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Item> addProducts = [];
    extractedData["products"].forEach((itemData) {
      addProducts.add(
        Item(
          id: itemData['id'],
          title: itemData['title'],
          price: itemData['price'],
          thumbnail: itemData['thumbnail'],
          stock: itemData['stock'],
        ),
      );
    });
    setState(() {
      searchItem.addAll(addProducts);
    });
  }

  //hàm chuyển giọng nói thành text
  void onListen() async {
    bool available = await _speech!.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'));

    if (!_isListening) {
      if (available) {
        setState(() {
          _isListening = true;
          _speech!.listen(
            onResult: (val) => setState(() {
              _textEditingController.text = val.recognizedWords;
            }),
          );
        });
      }
    } else {
      setState(() {
        _isListening = false;
        _speech!.stop();
      });
    }
  }

  void search(String query) {
    searchData(_textEditingController.text);
    final suggestions = listProducts.where((item) {
      final name = item.title.toString().toLowerCase();
      final input = query.toLowerCase();
      return name.contains(input);
    }).toList();
    setState(() => {searchItem = suggestions});
  }

  @override
  void initState() {
    super.initState();

    print(_checkLoad);
    _fetchData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _checkLoad) {
        _getMoreData();
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _speech = stt.SpeechToText();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  _getMoreData() {
    setState(() {
      getSperpage(numberLoadProduct += 20);
    });
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
          Row(
            children: [
              AvatarGlow(
                animate: _isListening,
                endRadius: 20,
                glowColor: Theme.of(context).primaryColor,
                duration: const Duration(milliseconds: 2000),
                repeatPauseDuration: const Duration(microseconds: 100),
                repeat: true,
                child: FloatingActionButton(
                  onPressed: () => onListen(),
                  child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                ),
              ),
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
              ),
            ],
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
              childAspectRatio: 0.71,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
        ),
      ),
    );
  }
}
