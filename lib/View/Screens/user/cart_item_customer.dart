import 'package:cred_books/Logic/Controller/cart_controller.dart';
import 'package:cred_books/Logic/Controller/product_controller.dart';
import 'package:cred_books/Model/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Utils/text_utils.dart';
import '../../../Utils/theme.dart';

class CardItem extends StatelessWidget {
  CardItem({
    Key? key,
  }) : super(key: key);
  List prodects = [];
  final controller = Get.find<ProdectController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Expanded(
        child: controller.searchList.isEmpty &&
                controller.searchTextController.text.isNotEmpty
            ? Get.isDarkMode
                ? Icon(
                    Icons.search_off_outlined,
                    size: 150,
                    color: Colors.grey,
                  )
                : Icon(
                    Icons.search_off_outlined,
                    size: 150,
                    color: Colors.white,
                  )
            : GridView.builder(
                itemCount: controller.searchList.isEmpty
                    ? controller.prodects.length
                    : controller.searchList.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 30,
                  maxCrossAxisExtent: 200,
                ),
                itemBuilder: (context, index) {
                  if (controller.searchList.isEmpty) {
                    return buildCardItems(
                        productNumber: controller.prodects[index].productNumber,
                        catagory: controller.prodects[index].category,
                        productName: controller.prodects[index].productName,
                        image: controller.prodects[index].imageUrl,
                        price: controller.prodects[index].price,
                        productId:
                            controller.prodects[index].productNumber.toString(),
                        productModels: controller.prodects[index],
                        onTap: () {
                          // Get.to(() => ProductDetailsScreen(
                          //   productModels: controller.productList[index],
                          // ));k
                        });
                  } else {
                    return buildCardItems(
                        productNumber: controller.searchList[index].productNumber,
                        catagory: controller.searchList[index].category,
                        productName: controller.searchList[index].productName,
                        image: controller.searchList[index].imageUrl,
                        price: controller.searchList[index].price,
                        productId: controller.searchList[index].productNumber
                            .toString(),
                        productModels: controller.searchList[index],
                        onTap: () {
                          // Get.to(() => ProductDetailsScreen(
                          //   productModels: controller.searchList[index],
                          // ));
                        });
                  }
                },
              ),
      );
    });
  }

  Widget buildCardItems({
    required String productName,
    required String catagory,
    required String image,
    required double price,
    required String productId,
    required Prodect productModels,
    required Function() onTap,
    required productNumber,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
          onTap: onTap,
          child: Container(
            height: 200,
            width: 600,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          // controller.manageFavourites(productId);
                          controller.addProdectFav(productModels);
                        },
                        icon: controller.isFave(productName)
                            ? const Icon(
                                Icons.add,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.add,
                                color: Colors.grey,
                              ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextUtils(
                    text: " $productName",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontsize: 13),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextUtils(
                          text: " $catagory",
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontsize: 12),
                      Text(
                        "\$ $price",
                        style: const TextStyle(
                          color: googleColor,
                          fontWeight: FontWeight.bold,
                            fontSize: 12
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
