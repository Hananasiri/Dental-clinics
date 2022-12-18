import 'package:cred_books/Logic/Controller/cart_controller.dart';
import 'package:cred_books/Logic/Controller/main_controller.dart';
import 'package:get/get.dart';
import '../Controller/auth_controller.dart';
import '../Controller/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<ProdectController>(ProdectController());
    Get.put<MainController>(MainController());
    Get.put<CartController>(CartController());

  }
}
