// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../controller/shopping_lists_controller.dart';
import '../widget/button_widget.dart';
import '../widget/textformfield_widget.dart';

class ShoppingListsView extends StatefulWidget {
  const ShoppingListsView({super.key});

  @override
  State<ShoppingListsView> createState() => _ShoppingListsViewState();
}

class _ShoppingListsViewState extends State<ShoppingListsView> {
  final _controller = ShoppingListsController();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas listas'),
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (ctx) => _modalAddShoppingList(),
            ),
            icon: Icon(Icons.add),
          ),
          SizedBox(width: 16.0),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Container(
          height: 600,
          child: GridView.builder(
            itemCount: _controller.shoppingLists.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0),
            itemBuilder: (context, index) => Card(
              child: InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  '/shopping_list_items',
                  arguments: _controller.shoppingLists[index].id,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_controller.shoppingLists[index].name),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _controller.shoppingLists[index].description ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _modalAddShoppingList() {
    var txtNameController = TextEditingController();
    var txtDescriptionController = TextEditingController();

    return Container(
      width: double.infinity,
      height: 420.0,
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nova lista de compras',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Informe o nome e também uma descrição para identificar sua nova lista de compras',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 32.0),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormFieldWidget(
                  label: 'nome',
                  hintText: 'Lista de compras',
                  controller: txtNameController,
                  validator: (value) =>
                      _controller.validateShoppingListName(value),
                ),
                SizedBox(height: 16.0),
                TextFormFieldWidget(
                  label: 'descrição',
                  hintText: 'Minha nova lista de compras',
                  controller: txtDescriptionController,
                  maxLines: 2,
                  maxLength: 120,
                ),
              ],
            ),
          ),
          Spacer(),
          ButtonWidget(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(
                  () {
                    _controller.addShoppingList(
                      context: context,
                      name: txtNameController.text,
                      description: txtDescriptionController.text,
                    );
                  },
                );
              }
            },
            text: 'Criar nova lista',
            color: Colors.blue,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
