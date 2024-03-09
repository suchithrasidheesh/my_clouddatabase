import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_clouddatabase/HttpAPIEg/Service/seivice_http.dart';

class cartController extends GetxController{
      RxBool isloading=true.obs;
      var cartlist=[].obs;
      @override
  void onInit() {
    loadCart();
    super.onInit();
  }

  void loadCart() async{
        try{
          isloading(true);
          var data=await ServiceHttp.fetchdata();
          if(data!=null){
            cartlist.value=data;
          }
        }finally{
          isloading(false);
        }

  }

}
