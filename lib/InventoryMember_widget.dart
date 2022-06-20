import 'package:flutter/material.dart';
import 'InventoryMember.dart';

class InventoryMemberWidget extends StatelessWidget {
  final MaterialColor myColor;
  final Product ivm;
  final VoidCallback add;
  final VoidCallback remove;
  final VoidCallback edit;
  const InventoryMemberWidget(
      {Key? key,
      required this.ivm,
      required this.myColor,
      required this.add,
      required this.remove,
      required this.edit})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 5.0, color: myColor),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(ivm.name,
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center),
            Text(
              "Quantité : ${ivm.quantity}",
              style: Theme.of(context).textTheme.headline2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // use whichever suits your need
              children: [
                ClipOval(
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      splashColor: myColor,
                      onTap: remove,
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.remove, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                ClipOval(
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      splashColor: myColor,
                      onTap: add,
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.add, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                ClipOval(
                  child: Material(
                    color: Colors.white,
                    child: InkWell(
                      splashColor: myColor,
                      onTap: edit,
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.edit, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
