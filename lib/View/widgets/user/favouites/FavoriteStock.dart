import 'package:cred_books/Logic/Controller/product_controller.dart';
import 'package:cred_books/Model/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../admin/popupMenu/popupMenu.dart';

class FavoriteInStock extends StatelessWidget {
  List<dynamic> prodect;

  FavoriteInStock ({super.key, required this.prodect,
  });
  final controller = Get.find<ProdectController>();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: prodect.length,
        itemBuilder: ((context, index) {
          return Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            height: 150,
            width: 800,
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Container(
                  height: 110,
                  width: 110,
                  margin: EdgeInsets.only(left: 15),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                          image: NetworkImage('${prodect[index].imageUrl}'),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: 22,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              "${prodect[index].productNumber}",
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          Spacer(),

                                        IconButton(onPressed: (){
                                      controller.deleteeData(prodect[index].productNumber);
                                        },
                                        icon: Icon(
                                          Icons.delete_forever_sharp,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                            ),
                          //   PopupMenu(
                          //     prodectId: '${prodect[index].productNumber}',
                          //     productName: '${prodect[index].productName}',
                          //     category: '${prodect[index].category}',
                          //     quantity: '${prodect[index].quantity}',
                          //     price: '${prodect[index].price}',
                          //     description: '${prodect[index].description}',
                          //     imageUrl: '${prodect[index].imageUrl}',
                          //   ),
                          ],
                        ),
                      ),
                         
                      Text(
                        "${prodect[index].productName}",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "${prodect[index].category}",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        "${prodect[index].quantity}",
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(children: [
                        Text("\$${prodect[index].price}",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                        // Spacer(),
                        // Switch(
                        //   value: true,
                        //   onChanged: (value) {},
                        //   activeTrackColor: Color.fromRGBO(67, 24, 255, 1),
                        //   activeColor: Colors.white,
                        // ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        )
    );
  }
}
