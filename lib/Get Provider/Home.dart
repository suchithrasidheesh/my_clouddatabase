import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

void main(){
  runApp(GetMaterialApp(
    home: MyHome(),
  ));
}
class MyHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final CountController controller=Get.put(CountController());
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Counter example')),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Obx(() => Text("Count=${controller.count}")),
            SizedBox(height:20,),
            ElevatedButton(onPressed: ()=>controller.increment(), child:Text('Increment')),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: ()=>controller.decrement(), child:Text('Decrement'))
          ],
        ),
      ),
    );
  }

}