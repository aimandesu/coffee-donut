class Order {
  final List<Map<String, List>>? order;

  Order({required this.order});

  Map<String, dynamic> toJson() => {
        'order': order,
      };
}
