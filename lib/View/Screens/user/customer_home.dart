import 'package:cred_books/Model/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import '../../../Logic/Controller/product_controller.dart';
import 'cart_item_customer.dart';

class CustomerHome extends StatelessWidget {
  CustomerHome({Key? key}) : super(key: key);

  final controller = Get.put(ProdectController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(height: 60,),
        Container(
          //margin: EdgeInsets.only(top: 20),
            child: Text(
              "My Clinics",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            )),
        SizedBox(height: 40),

        StreamBuilder(
          stream: controller.getData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
              print('leeength ${controller.prodects.length}');

              print('leeength ${controller.imgUrl}');
              if (controller.prodects.isNotEmpty) {
                return CardItem();
              } else {
                return Text("No thing");
              }
            } else {
              return CardItem();
            }
          },
        ),
      ]),
    );
  }
}
