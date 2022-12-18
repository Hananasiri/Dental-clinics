import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Routes/routes.dart';

class loginScreen extends StatelessWidget {
  const loginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var admin = 'admin@gmail.com';
    var emailController = TextEditingController();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'please enter your name',
              labelText: 'Name ',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: emailController,
            onChanged: (value) {
              value = emailController.text;
            },
            decoration: const InputDecoration(
              icon: Icon(Icons.email),
              hintText: 'please enter your email',
              labelText: 'Email',
            ),
          ),
          TextButton(
              onPressed: () {
                if (emailController.text == admin) {
                  Get.toNamed(Routes.stockScreen);
                  //print('hi admin');
                } else {
                  Get.toNamed(Routes.customerHome);
                  //print('Hiiii');
                }
              },
              child: const Text('Enter'))
        ]),
      ),
    );
  }
}
