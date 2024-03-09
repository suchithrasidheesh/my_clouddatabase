import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_clouddatabase/HttpAPI/controller/productController.dart';

import '../widget/ProductCustom.dart';

void main(){
  runApp(GetMaterialApp(home: HttpHome(),));
}

class HttpHome extends StatelessWidget{
  final ProductController controller=Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: [
          Icon(Icons.shopping_cart)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Shop Now'),
          Expanded(
              child: Obx(() {
                if (controller.isloading.value){
                  return Center(child: CircularProgressIndicator());
                }else{
                  return GridView.builder(gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
                      itemBuilder:(context,index){
                        return ProductCustom(controller.productList[index]);
                      },itemCount: controller.productList.length,);
                }
              })
          )
        ],
      ),
    );
  }


}