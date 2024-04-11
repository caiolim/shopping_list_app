class ShoppingListItemModel {
  String id;
  String name;
  int quantity;
  bool isChecked;

  ShoppingListItemModel({
    required this.id,
    required this.name,
    required this.quantity,
    this.isChecked = false,
  });

  Map<String, dynamic> toJson(ShoppingListItemModel item) {
    Map<String, dynamic> json = {
      "id": item.id,
      "name": item.name,
      "quantity": item.quantity,
      "isChecked": item.isChecked,
    };

    return json;
  }

  factory ShoppingListItemModel.fromJson(Map<String, dynamic> json) =>
      ShoppingListItemModel(
        id: json['id'],
        name: json['name'],
        quantity: json['quantity'],
        isChecked: json['isChecked'] ?? false,
      );
}
