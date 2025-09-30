import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  var isListView = true.obs;
  var fileName = <String>[].obs;
  var files = <File>[].obs;
  var selectedIndex = 0.obs;

  void toggleView(){
    isListView.value = !isListView.value;
  }

  Future<void> pickFiles() async {


    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true
    );
    if(result != null){
      files.value = result.paths.map((path) => File(path!)).toList();
      fileName.value = result.names.map((name) => name!).toList();
    }
  }

  void onTapped(int index){
    selectedIndex.value = index;
  }
}