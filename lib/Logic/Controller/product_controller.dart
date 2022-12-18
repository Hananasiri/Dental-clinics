import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cred_books/Logic/Controller/auth_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../Model/product.dart';
import '../../Routes/routes.dart';
import '../../View/Screens/admin/stock_screen.dart';

class ProdectController extends GetxController {

  var searchList = <Prodect>[].obs;
  TextEditingController searchTextController = TextEditingController();
  var productMap = {}.obs;
  var productList = <Prodect>[].obs;
  late TextEditingController productNumberController,
      productNameControlller,
      productCategoryController,
      productQuantityController,
      productPriceController,
      productDescriptionController;

  final authcontroller = Get.put(AuthController());

  File? pickedFile;
  String imgUrl = "";
  final imagePicker = ImagePicker();
  var storage = GetStorage();

  final prodectRef = FirebaseFirestore.instance.collection('user');

  final getData = FirebaseFirestore.instance.collection('prodects').snapshots();

//  final findData = FirebaseFirestore.instance.collection('appointments').snapshots();

  List<dynamic> prodects = [];
  List<dynamic> appointments = [];

  //update varible
  var productName = ''.obs;
  var productCategory = ''.obs;
  var productQuantity = ''.obs;
  var productPrice = ''.obs;
  var productDescription = ''.obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    productNumberController = TextEditingController();
    productNameControlller = TextEditingController();
    productCategoryController = TextEditingController();
    productQuantityController = TextEditingController();
    productPriceController = TextEditingController();
    productDescriptionController = TextEditingController();
  }

  // add to firebase
  Future<void> addProdect(Prodect prodect) async {
    if (pickedFile == null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child("productImage")
          .child(productNameControlller.text + ".jpg");
      await ref.putFile(pickedFile!);
      imgUrl = await ref.getDownloadURL();
    } else {
      final ref = FirebaseStorage.instance
          .ref()
          .child("productImage")
          .child(productNameControlller.text + ".jpg");
      await ref.putFile(pickedFile!);
      imgUrl = await ref.getDownloadURL();
    }
    // we nede Refrence to firebase
    final prodectRef = FirebaseFirestore.instance.collection('prodects').doc();
        //.collection("appointments").doc();
    prodect.productNumber = prodectRef.id;
    prodect.imageUrl = imgUrl.toString();
    final data = prodect.toJson(); // insert to fiserbase
    prodectRef.set(data).whenComplete(() {
      clearController();
      Get.snackbar("", "Added successfully..");
      Get.to(StockScreen());
      update();
    }).catchError((error) {
      Get.snackbar("Error", "something went wrong");
    });
  }

  Future<void> TakePhoto(ImageSource sourse) async {
    final pickedImage =
    await imagePicker.pickImage(source: sourse, imageQuality: 100);

    pickedFile = File(pickedImage!.path);
    print("..............");
    print(pickedFile);
    print("..............");
  }
// add product in avorite
  Future<void> addProdectFav(Prodect prodect) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child("productImage").child(productNameControlller.text + ".jpg");
    final refr =
    prodectRef
        .doc(authcontroller.displayUserEmail.value)
        .collection("Favorite")
        .doc(prodect.productNumber);

    final data = prodect.toJson();
    prodect.productNumber = prodectRef.id;// insert to fiserbase
    refr.set(data).whenComplete(() {
      if(prodect.productNumber == prodectRef.id){
        Get.snackbar("", "Added successfully..");
      }else{
        Get.snackbar("", "error..");
      }
    }
    );
        update();
   }
//   Future<void> addProdectFav(Prodect prodect) async {
//     final ref = FirebaseStorage.instance
//         .ref()
//         .child("productImage").child(productNameControlller.text + ".jpg");
//     var refr = prodectRef.doc(authcontroller.displayUserEmail.value).collection("Favorite").doc(prodect.productName);
//     prodect.productNumber = prodectRef.id;
//     final data = prodect.toJson(); // insert to fiserbase
//     refr.set(data).whenComplete(() {
//       clearController();
//       Get.snackbar("", "Added successfully..");
//       if(prodect.productNumber == prodectRef.id){
//         print ("lll");
//         print(prodect.productNumber);
//         print ("ll");
//       }
//       // Get.offNamed(Routes.stockScreen);
//       update();
//     }).catchError((error) {
//
//       Get.snackbar("Error", "something went wrong");
//     });
//   }

  // update on firebase

  Future<void> updateProduct(
      productNumberController,
      productNameControlller,
      productCategoryController,
      productQuantityController,
      productPriceController,
      productDescriptionController,
      imgUrl) async {
    productName.value = productNameControlller.text;
    productCategory.value = productCategoryController.text;
    productQuantity.value = productQuantityController.text;
    productPrice.value = productPriceController.text;
    productDescription.value = productDescriptionController.text;
    imgUrl;

    final ref = FirebaseStorage.instance
        .ref()
        .child("productImage")
        .child(productNameControlller.text + ".jpg");
    if (pickedFile == null) {
    } else {
      await ref.putFile(pickedFile!);
      imgUrl = await ref.getDownloadURL();
    }

    final docProduct = FirebaseFirestore.instance
        .collection("prodects")
        .doc(productNumberController);
    docProduct.update({
      "productName": productName.value,
      "category": productCategory.value,
      "quantity": int.parse(productQuantity.value),
      "price": double.parse(productPrice.value),
      "description": productDescription.value,
      "imageUrl": imgUrl.toString(),
    }).whenComplete(() {
      print("update done");
      Get.snackbar("", "Update successfully..");
      clearController();
      update();
      Get.toNamed(Routes.stockScreen);
    });
  }

  // delete on firebase
  Future<void> deleteData(
      productNumberController, productNameControlller) async {
    await FirebaseFirestore.instance
        .collection('prodects')
        .doc(productNumberController)
        .delete()
        .whenComplete(() async {
      Get.snackbar("", "Delete successfully..");
      print("delete ${productNumberController}");

      FirebaseStorage.instance
          .ref()
          .child("productImage/")
          .child(productNameControlller + ".jpg")
          .delete()
          .whenComplete(() => print("image delete"));
    });
  }

  Future<void> deleteDataaa(String id) async {
    await FirebaseFirestore.instance
    .doc(authcontroller.displayUserEmail.value)
        .collection('Favorite')
        .doc(id)
        .delete();
      Get.snackbar("", "Delete successfully..");

      // FirebaseStorage.instance
      //     .ref()
      //     .child("productImage/")
      //     .child(productNameControlller + ".jpg")
      //     .delete()
      //     .whenComplete(() => print("image delete"));
    }

  // void removeOneProduct(Prodect productModels) async {
  //   if (productMap.containsKey(productModels)) {
  //     await prodectRef
  //         .doc(authcontroller.displayUserEmail.value)
  //         .collection("Favorite")
  //         .doc(productModels.productNumber)
  //         .delete();
  //     productMap.removeWhere((key, value) => key == productModels);
  //   } else {
  //     Get.snackbar("Error", "Somthing went wrong ");
  //   }
  // }
// true delete
  Future<void> deleteeData(var id) async {
    await prodectRef
        .doc(authcontroller.displayUserEmail.value)
        .collection('Favorite')
        .doc(id)
        .delete();
  }



  Future<void> deleteDatafromFav(
      productNumberController, productNameControlller) async {
    await FirebaseFirestore.instance
        .collection('prodects')
        .doc(productNumberController)
        .delete()
        .whenComplete(() async {
      Get.snackbar("", "Delete successfully..");
      print("delete ${productNumberController}");

      FirebaseStorage.instance
          .ref()
          .child("productImage/")
          .child(productNameControlller + ".jpg")
          .delete()
          .whenComplete(() => print("image delete"));
    });
  }
  // delete on firebase
  Future<void> deleteDatafrom(
      productNumberController, productNameControlller) async {
    await FirebaseFirestore.instance
        .collection("Favorite")
        .doc(productNumberController)
        .delete()
        .whenComplete(() async {
      Get.snackbar("", "Delete successfully..");
      print("delete ${productNumberController}");

      FirebaseStorage.instance
          .ref()
          .child("productImage/")
          .child(productNameControlller + ".jpg")
          .delete()
          .whenComplete(() => print("image delete"));
    });
  }

  void removeProductsFromCart(productNumberController, productNameControlller) {
    if (productMap.containsKey(productNumberController) &&
        productMap[productNumberController] == 1) {
      productMap.removeWhere((key, value) => key == productNumberController);
    } else {
      productMap[productNumberController] -= 1;
    }

    Get.snackbar("", "Delete successfully..");
    print("delete ${productNumberController}");
  }
  // void removeOneProduct(productNumberController, productNameControlller) {
  //   productMap.removeWhere((key, value) => key == productNumberController);
  // }
  // void clearAllProducts() {
  //   productMap.clear();
  // }




  // clear Controller
  void clearController() {
    productNameControlller.clear();
    productCategoryController.clear();
    productQuantityController.clear();
    productPriceController.clear();
    productDescriptionController.clear();
    pickedFile = null;
  }

  List<dynamic> favouritesList = [].obs;
  List<dynamic> prodectsFavourites = [];

  void manageFavourite(int productNumber) async {
    var existingIndex =
    favouritesList.indexWhere((element) => element.id == productNumber);

    if (existingIndex >= 0) {
      favouritesList.removeAt(existingIndex);
      await storage.remove("isFavouritedList");
    } else {
      favouritesList.add(productList.firstWhere((element) => element.productName == productNumber));
          //.add(productList.firstWhere((element) => element.id == productNumber));
      await storage.write("isFavouritedList", favouritesList);
    }
  }

  bool isFavourites(int productId) {
    return favouritesList.any((element) => element.id == productId);
  }

  void manageFavourites(String id) {
    print('First isFav ${isFave(id)}');
    for (var i = 0; i < prodects.length; i++) {
      var fromj = prodectToJson(prodects[i]);
      var x = prodectFromJson(fromj);
      var y = x.toJson();
      if (y['productNumber'] == id && isFave(id) == false) {
        favouritesList.add(y);
        print("added!!!");
        Get.snackbar(
          'Success!',
          "Added your Appointments",
          colorText: Colors.black,
        );
      }
    }
    print('Seconed isFav ${isFave(id)}');
  }

  bool isFave(String productId) {
    return favouritesList
        .any((element) => element['productNumber'] == productId);
  }

  void addSearchToList(String searchName) {
    searchName = searchName.toLowerCase();

    searchList.value = productList.where((search) {
      var searchTitle = search.productName.toLowerCase();
      var searchPrice = search.price.toString().toLowerCase();

      return searchTitle.contains(searchName) ||
          searchPrice.toString().contains(searchName);
    }).toList();

    update();
  }

  void clearSearch() {
    searchTextController.clear();
    addSearchToList("");
  }

}
