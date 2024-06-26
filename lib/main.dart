import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import './view/about_view.dart';
import './view/login_view.dart';
import './view/register_view.dart';
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
      color: Colors.blue,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      title: 'Navegação',
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/about':
            return MaterialPageRoute(
              builder: (context) => const AboutView(),
            );
          case '/login':
            return MaterialPageRoute(
              builder: (context) => const LoginView(),
            );
          case '/register':
            return MaterialPageRoute(
              builder: (context) => const RegisterView(),
            );
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
