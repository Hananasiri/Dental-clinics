import 'package:badges/badges.dart';
import 'package:cred_books/Logic/Controller/cart_controller.dart';
import 'package:cred_books/Logic/Controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Logic/Controller/auth_controller.dart';
import '../../../Logic/Controller/product_controller.dart';
import '../../../Routes/routes.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final mainController = Get.find<MainController>();
  final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
            () {
          return SafeArea(
              child: Scaffold(
                bottomNavigationBar: BottomNavigationBar(
                  //هنا بداية البوتوم نافيقيشن بار
                  currentIndex: mainController.currentIndex.value,
                  type: BottomNavigationBarType.fixed,
                  items: [
                    BottomNavigationBarItem(
                      activeIcon: Icon(
                        Icons.medical_services_outlined,
                      ),
                      icon: Icon(
                        Icons.medical_services_outlined,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                      label: '',
                    ),

                    BottomNavigationBarItem(
                      activeIcon: Icon(
                        Icons.app_registration,
                      ),
                      icon: Icon(
                        Icons.app_registration,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      activeIcon: Icon(
                        Icons.perm_identity,
                      ),
                      icon: Icon(
                        Icons.perm_identity_rounded,
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                      ),
                      label: '',
                    ),
                  ],

                  onTap: (index) {
                    mainController.currentIndex.value = index;
                  },
                ),
                body: IndexedStack(
                  index: mainController.currentIndex.value,
                  children: mainController.tabs.value,
                ),
              ));
        },
      ),
    );
  }
}
