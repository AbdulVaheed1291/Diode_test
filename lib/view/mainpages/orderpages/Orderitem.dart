// order_item.dart
class OrderItem {
  final String? id;
  final String name;
  final String price;
  final String date;
  final String time;
  final String status;
  final String imageUrl;

  OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.date,
    required this.time,
    required this.status,
    required this.imageUrl,
  });
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'date': date,
    'time': time,
    'status': status,
    'imageUrl': imageUrl,
  };

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json['id'],
    name: json['name'],
    price: json['price'],
    date: json['date'],
    time: json['time'],
    status: json['status'],
    imageUrl: json['imageUrl'],
  );
}