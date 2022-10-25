class Item {
  int id;
  String? title;
  int price;
  String? thumbnail;
  int? stock;

  Item({
    required this.id,
    this.title,
    required this.price,
    this.thumbnail,
    this.stock,
  });
}

List<Item> test = [
  Item(
      id: 10,
      stock: 20,
      title: 'abc',
      thumbnail:
          'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/m/sm-f926_zfold3_5g_openback_phantomsilver_210611.jpg',
      price: 20000),
  Item(
      id: 10,
      stock: 20,
      title: 'xyz',
      thumbnail:
          'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/m/sm-f926_zfold3_5g_openback_phantomsilver_210611.jpg',
      price: 20000),
];
