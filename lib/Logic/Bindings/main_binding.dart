import 'package:cred_books/Logic/Controller/main_controller.dart';
import 'package:get/get.dart';


class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());

  }
}