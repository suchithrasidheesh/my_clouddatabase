import '../Model/Cart_model.dart';
import 'package:http/http.dart'as http;

class ServiceHttp{
  static Future<List<Cart>>fetchdata()async{
    var result=await http.get(Uri.parse('https://fakestoreapi.com/carts'));
    if(result.statusCode==200){
      var data=result.body;
      return cartFromJson(data);
    }
    else{
      throw Exception();
    }
  }
    
}