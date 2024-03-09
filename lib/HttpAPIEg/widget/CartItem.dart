import 'package:flutter/cupertino.dart';

import '../Model/Cart_model.dart';

class CartItem extends StatelessWidget{
  final Cart cartList;
  CartItem(this.cartList);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 30,),
          Text('Product Code:${cartList.id}'),
          SizedBox(height: 30,),
          Text('User id:${cartList.userId}'),
          SizedBox(height: 30,),
          Text('Date:${cartList.date}'),
          SizedBox(height: 30,),
          Text('List of Items:${cartList.products}'),
          SizedBox(height: 30,),
          Text('${cartList.v}')
        ],
      ),
    );
  }

}