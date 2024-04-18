import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import './view/shopping_lists_view.dart';
import './view/shopping_list_items_view.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (BuildContext context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navegação',
      initialRoute: '/shopping_lists',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/shopping_lists':
            return MaterialPageRoute(
              builder: (context) => const ShoppingListsView(),
            );
          case '/shopping_list_items':
            final id = settings.arguments as String;

            return MaterialPageRoute(
              builder: (context) => ShoppingListItemsView(id: id),
            );
          default:
            return null;
        }
      },
    );
  }
}
