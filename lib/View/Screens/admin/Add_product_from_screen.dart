import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import '../../../Logic/Controller/product_controller.dart';
import '../../../Model/product.dart';
import '../../widgets/admin/add_product_widget/text_field_product.dart';
import '../../widgets/admin/add_product_widget/text_utils.dart';


class AddProductFromScreen extends StatelessWidget {
  AddProductFromScreen({Key? key}) : super(key: key);

  final controller = Get.find<ProdectController>();

  // final controller = Get.find<AddProductController>();
  final myKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var s = null.obs;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("Cancel",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400)),
        ),
        title: Text(
          "Add new clinic",
          style: TextStyle(
              color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w700),
        ),
        // titleSpacing: 50,
        centerTitle: true,

        actions: [
          GetBuilder<ProdectController>(builder: (_) {
            return TextButton(
              onPressed: () async {
                if (myKey.currentState!.validate()) {
                  Prodect product = Prodect(
                      productName: controller.productNameControlller.text,
                      category: controller.productCategoryController.text,
                      quantity:
                      int.parse(controller.productQuantityController.text),
                      price:
                      double.parse(controller.productPriceController.text),
                      description: controller.productDescriptionController.text,
                      imageUrl: controller.imgUrl);
                  if (controller.pickedFile == null) {
                    print("no image slected");
                    Get.snackbar(
                      "Eroor",
                      "You must add image please",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Color.fromRGBO(217, 217, 217, 1),
                    );
                  }
                  await controller.addProdect(product);
                } else {
                  return;
                }
              },
              child: Text(
                "Add",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w400),
              ),
            );
          })
        ],
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 55),
          child: Form(
            key: myKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4.h,
                ),
                TextUtils(
                  text: 'Clinic Name',
                ),
                SizedBox(
                  height: 1.h,
                ),
                ProductTextField(
                  height: 5.h,
                  width: 200.w,
                  controller: controller.productNameControlller,
                  obscureText: false,
                  hintText: 'Clinic Name',
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return 'Enter Product Name Please';
                    }
                  },
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextUtils(
                  text: 'Category',
                ),
                SizedBox(
                  height: 1.h,
                ),
                ProductTextField(
                  height: 5.h,
                  width: 200.w,
                  controller: controller.productCategoryController,
                  obscureText: false,
                  hintText: 'Clinic Category',
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return 'Enter Clinic Category Please';
                    }
                  },
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                ),
                SizedBox(
                  height: 1.sp,
                ),
                TextUtils(
                  text: 'Quantity',
                ),
                SizedBox(
                  height: 1.sp,
                ),
                ProductTextField(
                  height: 5.h,
                  width: 200.w,
                  controller: controller.productQuantityController,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  hintText: 'Quantity',
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return 'Enter Product Quantity Please';
                    }
                  },
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                ),
                SizedBox(
                  height: 6.sp,
                ),
                TextUtils(
                  text: 'Price',
                ),
                SizedBox(
                  height: 6.sp,
                ),
                ProductTextField(
                  height: 5.h,
                  width: 200.w,
                  controller: controller.productPriceController,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  hintText: 'Price',
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return 'Enter Product Price Please';
                    }
                  },
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                ),
                SizedBox(
                  height: 6.sp,
                ),
                TextUtils(
                  text: 'Description',
                ),
                SizedBox(
                  height: 6.sp,
                ),
                ProductTextField(
                  height: 10.h,
                  width: 200.w,
                  controller: controller.productDescriptionController,
                  obscureText: false,
                  hintText: 'placeholder',
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return 'Enter Product Description Please';
                    }
                  },
                  maxLength: 100,
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 30, horizontal: 8),
                ),
                SizedBox(
                  height: 6.sp,
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.TakePhoto(ImageSource.gallery);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(217, 217, 217, 1),
                      padding: EdgeInsets.all(16),
                      minimumSize: Size(1, 6)),
                  child: Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Add Image",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
