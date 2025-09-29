import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:online_file_transfer/controller/splash_controller.dart';
import 'package:online_file_transfer/core/utilis/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(

        children: [
          SizedBox(height: h * .4,),
          Center(
            child: Container(
              height: h * .07,
              width: w * .25,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                    image: AssetImage('assets/images/splash.png')),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Text('Online File Transfer',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 20),),
          SizedBox(height: h * .35,),
          Obx((){
            return SizedBox(
              height: h * .007,
              width: w * .5,
              child: Center(
                child: LinearProgressBar(
                  currentStep: controller.currentSteps.value,
                  maxSteps: controller.totalSteps,
                  backgroundColor: Colors.grey.shade100,
                  progressColor: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            );
          }),
          SizedBox(height: 10,),
          Text('Version 1.0.1',style: TextStyle(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.w600),)
        ],
      ),
    );
  }
}
