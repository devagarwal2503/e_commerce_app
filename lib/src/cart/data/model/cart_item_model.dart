class CartItem {
  final String id;
  final String name;
  final String desc;
  final String imageUrl;
  final double price;
  int quantity; // Extra field not in your static JSON

  CartItem({
    required this.id,
    required this.name,
    required this.desc,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
  });

  // Convert JSON Map to CartItem
  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: json['id'],
    name: json['name'],
    desc: json['desc'],
    imageUrl: json['imageUrl'],
    price: json['price'].toDouble(),
    quantity: json['quantity'] ?? 1,
  );

  // Convert CartItem to JSON Map
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'desc': desc,
    'imageUrl': imageUrl,
    'price': price,
    'quantity': quantity,
  };
}
