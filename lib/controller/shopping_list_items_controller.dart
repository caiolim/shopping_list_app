import 'package:flutter/material.dart';
import 'package:shopping_list_app/model/shopping_list_item_model.dart';
import 'package:shopping_list_app/model/shopping_list_model.dart';

class ShoppingListItemsController {
  late final ShoppingListModel shoppingList;

  void initState({String id = '6c84fb90-12c4-11e1-840d-7b25c5ee775a'}) {
    for (var json in jsonShoppingLists) {
      if (id == json['id']) {
        shoppingList = ShoppingListModel.fromJson(json);

        if (json['items'] != null) {
          final items = <ShoppingListItemModel>[];

          for (var jsonItem in json['items'] as List) {
            items.add(ShoppingListItemModel.fromJson(jsonItem));
          }

          shoppingList.items = items;
        }
      }
    }
  }

  saveChanges(BuildContext context, {required id}) {
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
}

enum Options { edit, delete }

const jsonShoppingLists = [
  {
    'id': '6c84fb90-12c4-11e1-840d-7b25c5ee775a',
    'name': 'Compras do mês',
    'description': 'Lista de itens comprados todo mês no supermercado',
    'items': [
      {
        'id': 'xxxx',
        'name': 'Maçã',
        'quantity': 5,
        'isChecked': false,
      },
      {
        'id': 'yyyy',
        'name': 'Banana',
        'quantity': 8,
        'isChecked': true,
      },
      {
        'id': 'zzzz',
        'name': 'Abacaxi',
        'quantity': 2,
        'isChecked': false,
      },
    ],
  },
];
