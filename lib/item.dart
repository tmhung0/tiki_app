class Item {
  final String name;
  final int price;
  final String image;
  final int vote;
  final String quantity;
  const Item(
      {required this.name,
      required this.price,
      required this.image,
      required this.vote,
      required this.quantity});
}

//tên sản phẩm, giá tiền, hình ảnh, đánh giá (vote), số lượng đã bán.

const items = [
  Item(
      name: 'IPhone 13 Pro Max 128GB | Chính hãng VN/A',
      price: 27000000,
      image:
          'https://cdn2.cellphones.com.vn/358x/media/catalog/product/3/_/3_51_1_7.jpg',
      vote: 5,
      quantity: '21'),
  Item(
      name: 'Xiaomi Redmi Note 11 Pro Plus 5G',
      price: 8900000,
      image:
          'https://cdn2.cellphones.com.vn/358x/media/catalog/product/1/1/11-pro-plus-blue.jpg',
      vote: 5,
      quantity: '25'),
  Item(
      name: 'Samsung Galaxy A33 (5G)',
      price: 6800000,
      image:
          'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/a/samsung-galaxy-a33-5g-500x500.jpg',
      vote: 5,
      quantity: '25'),
  Item(
      name: 'Samsung Galaxy Z Fold3 5G',
      price: 21000000,
      image:
          'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/m/sm-f926_zfold3_5g_openback_phantomsilver_210611.jpg',
      vote: 5,
      quantity: '44'),
  Item(
      name: 'hung',
      price: 21000000,
      image:
          'https://cdn2.cellphones.com.vn/358x/media/catalog/product/s/m/sm-f926_zfold3_5g_openback_phantomsilver_210611.jpg',
      vote: 5,
      quantity: '44')
];
