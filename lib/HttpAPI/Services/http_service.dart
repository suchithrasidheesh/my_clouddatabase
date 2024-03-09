import 'package:my_clouddatabase/HttpAPI/model/productModel.dart';
import 'package:http/http.dart' as http;

class HttpService{
   static Future<List<Product>>fetchProducts()async{

      var response=await http.get(Uri.parse('http://fakestoreapi.com/products'));
      if(response.statusCode==200){
         var data=response.body;
         return productFromJson(data);
      }else{
         throw Exception();
      }
   }
}