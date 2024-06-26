import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../model/shopping_list_model.dart';
import '../model/shopping_list_item_model.dart';

class ShoppingListItemsController {
  late ShoppingListModel shoppingList;
  late List<ShoppingListItemModel> displayedItems;

  void initState({required String id}) {
    shoppingList = ShoppingListModel(id: id, name: 'Nova lista de compras');
    final items = <ShoppingListItemModel>[];

    for (var json in jsonShoppingLists) {
      if (id == json['id']) {
        shoppingList = ShoppingListModel.fromJson(json);

        if (json['items'] != null) {
          for (var jsonItem in json['items'] as List) {
            items.add(ShoppingListItemModel.fromJson(jsonItem));
          }
        }
      }
    }

    shoppingList.items = items;
    displayedItems = items;
  }

  void saveChanges(
    BuildContext context, {
    required String? id,
    required String name,
    required int quantity,
  }) {
    if (shoppingList.items == null) return;

    if (id == null) {
      // Create
      var item = ShoppingListItemModel(
        id: const Uuid().v4(),
        name: name,
        quantity: quantity,
      );

      shoppingList.items!.add(item);
      displayedItems = shoppingList.items!;
    } else {
      // Update
      final indexItem = shoppingList.items!.indexWhere((e) => e.id == id);
      var item = shoppingList.items!.elementAt(indexItem);

      item.name = name;
      item.quantity = quantity;

      shoppingList.items![indexItem] = item;
    }

    Navigator.pop(context);
  }

  String? validateItemName(String? text) {
    if (text == null || text.isEmpty) {
      return 'Informe o nome';
    }

    return null;
  }

  String? validateItemQuantity(String? text) {
    if (text == null || text.isEmpty) {
      return 'Informe a quantidade';
    }

    return null;
  }

  void findByName({required String text}) {
    if (text.isEmpty) displayedItems = shoppingList.items!;

    displayedItems = shoppingList.items!
        .where(
          (e) => e.name.toLowerCase().contains(text.toLowerCase()),
        )
        .toList();
  }

  removeById({required BuildContext context, required String id}) {
    shoppingList.items!.removeWhere((item) => item.id == id);
    displayedItems = shoppingList.items!;

    Navigator.pop(context);
  }
}

enum Options { edit, delete }

const jsonShoppingLists = [
  {
    "id": "6c84fb90-12c4-11e1-840d-7b25c5ee775a",
    "name": "Compras do mês",
    "description": "Lista de itens comprados todo mês no supermercado",
    "items": [
      {"id": "xxxx", "name": "Detergente", "quantity": 3, "isChecked": false},
      {"id": "yyyy", "name": "Amaciante", "quantity": 1, "isChecked": true},
      {"id": "zzzz", "name": "Arroz 5kg", "quantity": 2, "isChecked": true}
    ]
  },
  {
    "id": "110ec58a-a0f2-4ac4-8393-c866d813b8d1",
    "name": "Compras da semana",
    "description": "Lista de itens comprados toda semana no supermercado",
    "items": [
      {"id": "xxxx", "name": "Maçã", "quantity": 5, "isChecked": false},
      {"id": "yyyy", "name": "Banana", "quantity": 8, "isChecked": false},
      {"id": "zzzz", "name": "Abacaxi", "quantity": 2, "isChecked": false}
    ]
  }
];
