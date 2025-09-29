import 'package:get/get.dart';
import 'package:online_file_transfer/view/auth/signin_screen.dart';

class SplashController extends GetxController{

  var currentSteps = 1.obs;
  final int totalSteps = 4;

  @override
  void onInit() {
    super.onInit();
    startProgress();
  }

  void startProgress() async {

   for(int i = 1; i<= totalSteps; i++){
     await Future.delayed(Duration(seconds: 1),(){
       currentSteps.value = i;
       if(i == totalSteps){
         Get.offAll(SigninScreen());
       }
     }
     );
   }
  }
}