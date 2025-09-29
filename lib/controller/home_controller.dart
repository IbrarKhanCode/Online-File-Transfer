import 'package:get/get.dart';

class HomeController extends GetxController {

  var isListView = true.obs;

  void toggleView(){
    isListView.value = !isListView.value;
  }

}