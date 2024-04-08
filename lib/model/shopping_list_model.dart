class ShoppingListModel {
  String id;
  String name;
  String description;

  ShoppingListModel({
    required this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson(ShoppingListModel shoppingList) {
    Map<String, dynamic> json = {
      'id': shoppingList.id,
      'name': shoppingList.name,
      'description': shoppingList.description,
    };

    return json;
  }

  factory ShoppingListModel.fromJson(Map<String, dynamic> json) =>
      ShoppingListModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
      );
}
