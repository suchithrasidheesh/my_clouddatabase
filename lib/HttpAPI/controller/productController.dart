import 'package:get/get.dart';
import 'package:my_clouddatabase/HttpAPI/Services/http_service.dart';

class ProductController extends GetxController{

  RxBool isloading=true.obs;//loading is now observable

  var productList=[].obs;

  @override

  void onInit() {  // what should happen when the app is loaded
    loadProduct();
    super.onInit();
  }

  void loadProduct() async{
    try{
      isloading(true);
      var product= await HttpService.fetchProducts();//fetch the list of product
      if(product!=null){
        productList.value=product;//now the list having values
      }
    }finally{
      isloading(false);
    }

  }
}