import '../model/shopping_list_item_model.dart';

class ShoppingListModel {
  String id;
  String name;
  String description;
  List<ShoppingListItemModel>? items;

  ShoppingListModel({
    required this.id,
    required this.name,
    required this.description,
    this.items,
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
