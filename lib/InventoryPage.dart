import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wei_inventoryv1/ChangeNamePopUp.dart';
import 'package:wei_inventoryv1/ConfirmationSuprPopUp.dart';
import 'InventoryMember.dart';
import 'InventoryMember_widget.dart';
import 'main.dart';


class Inventory extends StatefulWidget {
  final MaterialColor mainColor;
  final MaterialColor secondColor;
  final String title;
  final VoidCallback removeInventory;
  final List<Product> products = [];
  final List<MaterialColor> productsColors = [];
  Inventory({Key? keyI, required this.mainColor, required this.secondColor, required this.title, required this.removeInventory}) : super(key: keyI);
  @override
  State<Inventory> createState() => _InventoryState();
}

class _InventoryState extends State<Inventory> {

  late String name;

  @override
  initState() {
    super.initState();
    name = widget.title;
  }

  addItem(String newName){
    setState(() {
      widget.products.add(Product(newName, 1));
      widget.productsColors.add(MyHomePage.randomMaterialColor());
    });
  }
  add(int index) {
    setState(() {
      widget.products[index] = widget.products[index].add();
    });
  }
  remove(int index) {
    setState(() {if (widget.products[index].quantity - 1 <= 0) {
      confirmationDeletion(index);
    } else {
      widget.products[index] = widget.products[index].remove();
    }});
  }
  renameProduct(String newName, int index) {
    setState(() {
      widget.products[index] = widget.products[index].rename(newName);
    });
  }
  renameInventory(String newName) {
    setState(() {
      name = newName;
    });
  }
  editInventoryMemberName(int index) {
    ChangeNamePopUp().show(context, "Entrez le nom du produit", widget.products[index].name, (newName) {
      renameProduct(newName, index);
    });
  }
  addInventoryMember() {
    ChangeNamePopUp().show(context, "Entrez le nom du produit", "", addItem);
  }
  confirmationDeletion(int index){
    ConfirmationSuprPopUp().show(context, "Voulez-vous vraiment retirer ce produit de l'inventaire?", () {
      setState(() {
        widget.products.removeAt(index);
        widget.productsColors.removeAt(index);
      });
    });
  }
  renameAndRequestInventory() {
    ChangeNamePopUp()
        .show(context, "Entrez le nom de l'inventaire", "", renameInventory);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 60,
              child : Text(
                name,
                style: Theme.of(context).textTheme.headline1,
              ),
            ), //Title of the inventory
            Row( // Row to create the buttons to rename and remove inventory
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ClipOval(
                  child: Material(
                    color: widget.mainColor,
                    child: InkWell(
                      splashColor: widget.secondColor,
                      onTap: renameAndRequestInventory,
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child : Icon(Icons.edit, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                  height: 60,
                ),
                ClipOval(
                  child: Material(
                    color: widget.secondColor,
                    child: InkWell(
                      splashColor: widget.mainColor,
                      onTap: widget.removeInventory,
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child : Icon(Icons.delete, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: GridView.builder(
                  itemBuilder: (context, index) => InventoryMemberWidget(
                    ivm: widget.products[index],
                    myColor: widget.productsColors[index],
                    add: () => add(index),
                    remove: () => remove(index),
                    edit: () => editInventoryMemberName(index),
                  ),
                  itemCount: widget.products.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 5/4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addInventoryMember,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}