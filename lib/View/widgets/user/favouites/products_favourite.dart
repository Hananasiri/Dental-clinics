import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cred_books/Logic/Controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../Logic/Controller/product_controller.dart';
import '../../../../Model/product.dart';
import '../popupMenu/popup_menu.dart';
import 'FavoriteStock.dart';
import 'empty_favourite.dart';

class prodectsFavourites extends StatelessWidget {
  prodectsFavourites({super.key});

  final controller = Get.put(ProdectController());
  final authController =  Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          toolbarHeight: 145,
          iconTheme: IconThemeData(color: Colors.black),
          title: Container(
              //margin: EdgeInsets.only(top: 20),
              child: Text(
            "My Appointments",
            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black , fontSize: 25),
          )),
          elevation: 0,
          centerTitle: true,
        ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user')
            .doc(authController.displayUserEmail.value)
            .collection("Favorite").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("not empty screen");
            controller.prodects = snapshot.data!.docs
                .map((e) => Prodect(
                productNumber: e['productNumber'],
                productName: e['productName'],
                description: e['description'],
                category: e['category'],
                price: e['price'],
                quantity: e['quantity'],
                imageUrl: e['imageUrl']))
                .toList();
            print("prodects.length   ${controller.prodects.length}");

            if (controller.prodects.isNotEmpty) {
              return FavoriteInStock(
                prodect: controller.prodects,
              );
            } else {
              print("empty screen");
              return EmptyScreen();
            }
          } else {
            return FavoriteInStock(
              prodect: controller.prodects,
            );
          }
        },
      ),
    );
  }
}
