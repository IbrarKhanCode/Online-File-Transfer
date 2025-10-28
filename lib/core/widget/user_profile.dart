import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed('/settingScreen');
      },
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/images/profileTwo.png'),
        radius: 22,
      ),
    );
  }
}
