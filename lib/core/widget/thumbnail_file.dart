import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_file_transfer/controller/home_controller.dart';

class ThumbnailFile extends StatefulWidget {
  const ThumbnailFile({super.key});

  @override
  State<ThumbnailFile> createState() => _ThumbnailFileState();
}

class _ThumbnailFileState extends State<ThumbnailFile> {

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

      ],
    );
  }
}
