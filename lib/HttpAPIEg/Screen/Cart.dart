import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_clouddatabase/HttpAPIEg/Controller/cart-Controller.dart';

import '../widget/CartItem.dart';

void main(){
  runApp(GetMaterialApp(home: CartHome(),));
}

class CartHome extends StatelessWidget{

  final cartController controller=Get.put(cartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      appBar: AppBar(
        backgroundColor: Colors.yellow[100],
        title: Center(child: Text('Cart')),
      ),
      body: Obx((){
        if(controller.isloading.value){
          return Center(child: CircularProgressIndicator());
        }
        else{
          return ListView.builder(itemBuilder: (context,index){
            return Column(
              children: [
                CartItem(controller.cartlist[index]),
                Divider(thickness: 1,color:Colors.grey ,)
              ],
            ) ;

          },itemCount:controller.cartlist.length ,);
        }

      }),
    );
  }
}