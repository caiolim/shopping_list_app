// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text('Sobre'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 32.0),
            Container(
              width: 160.0,
              height: 160.0,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/eu.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Caio Lima',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Flutter Developer',
              style: TextStyle(
                color: Colors.blue,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 64.0),
            Text(
              'Informações do app',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'O app tem o objetivo de proporcionar o gerenciamento de suas listas de compras de formas simples e intuitiva, ajudando as pessoas no dia a dia e facilitando no momento de realizar suas compras.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Spacer(),
            Text(
              'Material Theme',
            ),
          ],
        ),
      ),
    );
  }
}
