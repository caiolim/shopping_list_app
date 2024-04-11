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
  final txtSearch = TextEditingController();
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
                      controller: txtSearch,
                      hintText: 'Pesquisar',
                      inputBorder: UnderlineInputBorder(),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  IconButton(
                    onPressed: () => setState(
                      () => _controller.findByName(
                        text: txtSearch.text,
                      ),
                    ),
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
                itemCount: _controller.displayedItems.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    ListTile(
                      leading: Checkbox(
                        value: _controller.displayedItems[index].isChecked,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(
                            () => _controller.displayedItems[index].isChecked =
                                !_controller.displayedItems[index].isChecked,
                          );
                        },
                      ),
                      title: Column(
                        children: [
                          Text(
                            _controller.displayedItems[index].name,
                            style: TextStyle(
                              color: _controller.displayedItems[index].isChecked
                                  ? Colors.grey[400]
                                  : Colors.blue,
                              decorationColor: Colors.grey,
                              decoration:
                                  _controller.displayedItems[index].isChecked
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                            ),
                          ),
                          Text(
                            'Quantidade: ${_controller.displayedItems[index].quantity}',
                            style: TextStyle(
                              fontSize: 10.0,
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (ctx) => _modalCreateEditItem(
                            id: _controller.displayedItems[index].id,
                            name: _controller.displayedItems[index].name,
                            quantity:
                                _controller.displayedItems[index].quantity,
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
                      onPressed: () => setState(
                        () => _controller.removeById(id: id, context: context),
                      ),
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
                    name: txtName.text,
                    quantity: int.parse(txtQuantity.text),
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
