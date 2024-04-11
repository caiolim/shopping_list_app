// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shopping_list_app/controller/shopping_list_items_controller.dart';

import '../widget/button_widget.dart';
import '../widget/textformfield_widget.dart';

class ShoppingListItemsView extends StatefulWidget {
  const ShoppingListItemsView({super.key});

  @override
  State<ShoppingListItemsView> createState() => _ShoppingListItemsViewState();
}

class _ShoppingListItemsViewState extends State<ShoppingListItemsView> {
  final _controller = ShoppingListItemsController();
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _controller.shoppingList.name,
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        actions: [
          PopupMenuButton(
            tooltip: 'Menu de opções',
            itemBuilder: (context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: Options.edit,
                child: ListTile(
                  leading: Icon(Icons.edit_outlined, size: 16.0),
                  title: Text('Editar'),
                ),
              ),
              const PopupMenuItem(
                value: Options.delete,
                child: ListTile(
                  leading: Icon(Icons.delete_outline, size: 16.0),
                  title: Text('Apagar'),
                ),
              ),
            ],
          ),
          SizedBox(width: 8.0),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormFieldWidget(
                      hintText: 'Pesquisar',
                      inputBorder: UnderlineInputBorder(),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search_outlined,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.0),
            Expanded(
              child: ListView.builder(
                itemCount: _controller.shoppingList.items!.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      leading: Checkbox(
                        value: _controller.shoppingList.items![index].isChecked,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(
                            () => _controller
                                    .shoppingList.items![index].isChecked =
                                !_controller
                                    .shoppingList.items![index].isChecked,
                          );
                        },
                      ),
                      title: Text(
                        _controller.shoppingList.items![index].name,
                        style: TextStyle(
                          color:
                              _controller.shoppingList.items![index].isChecked
                                  ? Colors.grey[400]
                                  : Colors.black,
                          decorationColor: Colors.grey,
                          decoration:
                              _controller.shoppingList.items![index].isChecked
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (ctx) => _modalCreateEditItem(
                            id: _controller.shoppingList.items![index].id,
                            name: _controller.shoppingList.items![index].name,
                            quantity:
                                _controller.shoppingList.items![index].quantity,
                          ),
                        ),
                        icon: Icon(Icons.edit_outlined, size: 16.0),
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) => _modalCreateEditItem(),
        ),
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        tooltip: 'Adicionar item',
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _modalCreateEditItem({
    String? id,
    String? name,
    int? quantity,
  }) {
    var txtName = TextEditingController();
    var txtQuantity = TextEditingController();

    if (name != null) txtName.text = name;
    if (quantity != null) txtQuantity.text = '$quantity';

    return Container(
      width: double.infinity,
      height: 340.0,
      padding: EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                id == null ? 'Novo item' : 'Editar item',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              id != null
                  ? IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete_outline),
                      color: Colors.red.shade900,
                      tooltip: 'Excluir',
                    )
                  : SizedBox(),
            ],
          ),
          SizedBox(height: 24.0),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormFieldWidget(
                  label: 'nome',
                  controller: txtName,
                  validator: (value) => _controller.validateItemName(value),
                ),
                SizedBox(height: 16.0),
                TextFormFieldWidget(
                  label: 'quantidade',
                  controller: txtQuantity,
                  validator: (value) => _controller.validateItemQuantity(value),
                ),
              ],
            ),
          ),
          Spacer(),
          ButtonWidget(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(
                  () => _controller.saveChanges(
                    context,
                    id: id,
                  ),
                );
              }
            },
            text: 'Salvar',
            color: Colors.blue,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
