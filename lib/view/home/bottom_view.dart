import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_file_transfer/controller/home_controller.dart';
import 'package:online_file_transfer/core/utilis/app_colors.dart';
import 'package:online_file_transfer/view/home/favourite_screen.dart';
import 'package:online_file_transfer/view/home/home_screen.dart';
import 'package:online_file_transfer/view/home/my_files_screen.dart';
import 'package:online_file_transfer/view/home/share_screen.dart';

class BottomView extends StatefulWidget {
  const BottomView({super.key});

  @override
  State<BottomView> createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {

  final controller = Get.put(HomeController());

final List<Widget> screens = [
  HomeScreen(),
  MyFilesScreen(),
  ShareScreen(),
  FavouriteScreen(),
];

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.onTapped,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.grey,

            items: [

              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/images/home.png')),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/images/files.png')),
                  label: 'My Files'
              ),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/images/share.png')),
                  label: 'Shared'
              ),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/images/star.png')),
                  label: 'Favorite'
              ),
            ]
        ),
        body: screens[controller.selectedIndex.value],
      );
    });
  }
}
