import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../model/shopping_list_model.dart';

class ShoppingListsController {
  var shoppingLists = <ShoppingListModel>[];

  void initState() {
    for (var json in jsonShoppingLists) {
      shoppingLists.add(ShoppingListModel.fromJson(json));
    }
  }

  void addShoppingList({
    required BuildContext context,
    required String name,
    required String description,
  }) {
    shoppingLists.add(
      ShoppingListModel(
        id: const Uuid().v4(),
        name: name,
        description: description,
      ),
    );

    Navigator.pop(context);
  }

  String? validateShoppingListName(String? text) {
    if (text == null || text.isEmpty) {
      return 'Informe o nome da nova lista';
    }

    return null;
  }
}

const jsonShoppingLists = [
  {
    "id": "6c84fb90-12c4-11e1-840d-7b25c5ee775a",
    "name": "Compras do mês",
    "description": "Lista de itens comprados todo mês no supermercado",
    "items": [
      {"id": "xxxx", "name": "Maçã", "quantity": 5, "isChecked": false},
      {"id": "yyyy", "name": "Banana", "quantity": 8, "isChecked": true},
      {"id": "zzzz", "name": "Abacaxi", "quantity": 2, "isChecked": false}
    ]
  },
  {
    "id": "110ec58a-a0f2-4ac4-8393-c866d813b8d1",
    "name": "Compras da semana",
    "description": "Lista de itens comprados toda semana no supermercado",
    "items": [
      {"id": "xxxx", "name": "Maçã 2", "quantity": 5, "isChecked": false},
      {"id": "yyyy", "name": "Banana 2", "quantity": 8, "isChecked": true},
      {"id": "zzzz", "name": "Abacaxi 2", "quantity": 2, "isChecked": false}
    ]
  }
];
