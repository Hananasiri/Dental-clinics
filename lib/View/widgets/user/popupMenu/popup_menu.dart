import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../Logic/Controller/product_controller.dart';
import '../../../../Model/modelMenu_item.dart';
import '../../../../Model/menu_items.dart';

class PopupMenu extends StatelessWidget {
  String prodectId;
  String productName;
  String productNumber;

  PopupMenu(
      {super.key,
        required this.prodectId,
        required this.productName,
        required this.productNumber,
       });

  final controller = Get.put(ProdectController());
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuItemPoup>(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        onSelected: (item) {
          onSelected(context, item);
        },
        itemBuilder: (context) => [
          ...MenuItems.menuItemsUser.map(buildItem).toList(),
        ]);
  }

  PopupMenuItem<MenuItemPoup> buildItem(MenuItemPoup item) => PopupMenuItem(
      value: item,
      child: Container(
        width: double.infinity,
        height: 5.h,
        child: Row(
          children: [
            Icon(item.icon),
            Text(" "),
            Expanded(
              child: Text(
                item.text,
                style: TextStyle(color: item.color),
              ),
            )
          ],
        ),
      ));

  void onSelected(BuildContext context, MenuItemPoup item) {
    switch (item) {
      // case MenuItems.addToCart:
      //   break;

      case MenuItems.itemDelete:
       // controller.deleteeData(productNumber);;
        break;
}
  }
}
