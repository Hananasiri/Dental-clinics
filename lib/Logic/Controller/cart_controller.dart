import 'package:cred_books/Model/product.dart';
import 'package:get/get.dart';

  class CartController extends GetxController {
 var productMap = {}.obs;

  int quantity() {
  if (productMap.isEmpty) {
  return 0;
  } else {
  return productMap.entries
      .map((e) => e.value)
      .toList()
      .reduce((value, element) => value + element);
  }
  }
 void addProductToCart(Prodect productModels) {
  if (productMap.containsKey(productModels)) {
   productMap[productModels] += 1;

  } else {
   productMap[productModels] = 1;
  }
 }



  }


