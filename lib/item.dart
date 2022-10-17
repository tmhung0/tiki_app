class Item {
  String id;
  String? name;
  int price;
  String? image;
  int? vote;
  int? quantity;
  int? sold;

  Item(
      {required this.id,
      this.name,
      required this.price,
      this.image,
      this.vote,
      this.quantity,
      this.sold});
}

List<Item> test = [
  Item(
      id: '10',
      vote: 5,
      quantity: 20,
      sold: 10,
      name: 'abc',
      image:
          'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/m/sm-f926_zfold3_5g_openback_phantomsilver_210611.jpg',
      price: 20000),
  Item(
      id: '10',
      vote: 5,
      quantity: 20,
      sold: 10,
      name: 'xyz',
      image:
          'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/m/sm-f926_zfold3_5g_openback_phantomsilver_210611.jpg',
      price: 20000),
];
