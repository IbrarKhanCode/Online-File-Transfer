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

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Obx((){
      return Scaffold(
        bottomNavigationBar: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.white,
                child: Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                  height: 1,
                ),
              ),
              Container(
                height: h * .08,
                color: Colors.white,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: BottomNavigationBar(
                      currentIndex: controller.selectedIndex.value,
                      onTap: controller.onTapped,
                      backgroundColor: Colors.white,
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: AppColors.primaryColor,
                      unselectedItemColor: Colors.grey,
                      selectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w500
                      ),
                      useLegacyColorScheme: false,

                      items: [
                        BottomNavigationBarItem(
                          icon: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              controller.selectedIndex.value == 0 ?
                                  ImageIcon(AssetImage('assets/images/selected_home.png'))
                                  : ImageIcon(AssetImage('assets/images/unselected_home.png')),
                              SizedBox(height: 7,)
                            ],
                          ),
                            label: 'Home'
                        ),
                        BottomNavigationBarItem(
                            icon: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                controller.selectedIndex.value == 1 ?
                                ImageIcon(AssetImage('assets/images/selected_files.png'))
                                    : ImageIcon(AssetImage('assets/images/unselected_files.png')),
                                SizedBox(height: 7,)
                              ],
                            ),
                            label: 'My Files'
                        ),
                        BottomNavigationBarItem(
                            icon: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                controller.selectedIndex.value == 2 ?
                                ImageIcon(AssetImage('assets/images/selected_share.png'))
                                    : ImageIcon(AssetImage('assets/images/unselected_share.png')),
                                SizedBox(height: 7,)
                              ],
                            ),
                            label: 'Shared'
                        ),
                        BottomNavigationBarItem(
                            icon: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                controller.selectedIndex.value == 3 ?
                                ImageIcon(AssetImage('assets/images/selected_star.png'))
                                    : ImageIcon(AssetImage('assets/images/unselected_star.png')),
                                SizedBox(height: 7,)
                              ],
                            ),
                            label: 'Favourite'
                        ),
                      ]
                  ),
                ),
              ),
            ],
          ),
        ),
        body: screens[controller.selectedIndex.value],
      );
    });
  }
}
