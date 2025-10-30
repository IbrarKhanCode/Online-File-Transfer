import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:online_file_transfer/model/file_item.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {

  var homeListView = true.obs;
  var myFilesListView = true.obs;
  var sharedListView = true.obs;
  var favouriteListView = true.obs;
  var fileName = <String>[].obs;
  var files = <File>[].obs;
  var selectedIndex = 0.obs;
  var filteredFiles = <PlatformFile>[].obs;
  var platformFiles = <PlatformFile>[].obs;
  var favouriteFiles = <PlatformFile>[].obs;
  var sharedFiles = <PlatformFile>[].obs;

  void toggleFavourite(PlatformFile file) {
    if (favouriteFiles.contains(file)) {
      favouriteFiles.remove(file);
    } else {
      favouriteFiles.add(file);
    }
  }

  bool isFavourite(PlatformFile file) => favouriteFiles.contains(file);

  Future<void> shareFile(PlatformFile file) async {
    try {
      final filePath = file.path;
      if (filePath == null) return;

      await Share.shareXFiles([XFile(filePath)], text: 'Sharing ${file.name}');

      if (!sharedFiles.contains(file)) {
        sharedFiles.add(file);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
        animationDuration: Duration(milliseconds: 300),
        duration: Duration(seconds: 2),
        borderRadius: 8,
        borderWidth: 2,
      );
    }
  }

  bool isShared(PlatformFile file) => sharedFiles.contains(file);

  void deleteFile(PlatformFile file) {
    platformFiles.remove(file);
    filteredFiles.remove(file);
    favouriteFiles.remove(file);
    sharedFiles.remove(file);
  }

  void homeToggleView(){
    homeListView.value = !homeListView.value;
  }
  void myFilesToggleView(){
    myFilesListView.value = !myFilesListView.value;
  }
  void sharedToggleView(){
    sharedListView.value = !sharedListView.value;
  }
  void favouriteToggleView(){
    favouriteListView.value = !favouriteListView.value;
  }

  Future<void> pickFiles() async {


    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.any,
    );
    if(result != null){
      files.value = result.paths.map((path) => File(path!)).toList();
      fileName.value = result.names.map((name) => name!).toList();
      platformFiles.addAll(result.files);
      filteredFiles.addAll(result.files);
    }
  }

  void filterFiles(String query){
    if(query.isEmpty){
      filteredFiles.assignAll(platformFiles);
    }
    else{
      filteredFiles.assignAll(
       platformFiles.where((file) => file.name.toLowerCase().contains
         (query.toLowerCase())).toList()
      );
    }
  }

  void onTapped(int index){
    selectedIndex.value = index;
  }

}