import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../Routes/routes.dart';



class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  return Scaffold(
     backgroundColor: Colors.white,
       body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
        const Center(
         child: Text(
         'Dental Clinics',
         style: TextStyle(
         color: Colors.black,
          fontSize: 50,
         ),
         ),
         ),
        const SizedBox(
         height: 150,
        ),
        ElevatedButton(
        style: ElevatedButton.styleFrom(
        primary: Colors.black,
        onPrimary: Colors.white,
        elevation: 7,
        textStyle: const TextStyle(fontSize: 23),
        shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(32.0)),
          minimumSize: Size(220, 50),
         ),
          child: Text('Admin'),
           onPressed: () {
             Get.toNamed(Routes.stockScreen);
           },
         ),
           SizedBox(
             height: 10,
           ),
           ElevatedButton(
             style: ElevatedButton.styleFrom(
               primary: Colors.black,
               onPrimary: Colors.white,
               elevation: 7,
               textStyle: const TextStyle(fontSize: 23),
               shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(32.0)),
               minimumSize: Size(220, 50),
             ),
             child: Text('User'),
             onPressed: () {
               Get.toNamed(Routes.mainScreen);
             },
           ),
  ],
  ),
  );
  }
  }