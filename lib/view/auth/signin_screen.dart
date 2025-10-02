import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_file_transfer/controller/sign_in_controller.dart';
import 'package:online_file_transfer/core/utilis/app_colors.dart';
import 'package:online_file_transfer/view/home/bottom_view.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

  final controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: h * .3,),
          Center(
            child: Container(
              height: h * .22,
              width: w * .6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                    image: AssetImage('assets/images/sign_in.png'))
              ),
            ),
          ),
          SizedBox(height: 10,),
          Text(
            textAlign: TextAlign.center,
            'Save your files and share\n'
          'with your friends',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),),
          SizedBox(height: h * .1,),
          Obx((){
            return controller.isLoading.value ? CircularProgressIndicator(
              color: AppColors.primaryColor,
            )
                : GestureDetector(
              onTap: (){
                controller.googleSignIn();
              },
              child: Container(
                height: h * .06,
                width: w * .9,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.primaryColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/google.png'),
                    SizedBox(width: 10,),
                    Text('Continue With Google',style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.w600),)
                  ],
                ),
              ),
            );
          }),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 1,
                width: w * .27,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(3)
                ),
              ),
              SizedBox(width: 5,),
              Text('OR',style: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w600),),
              SizedBox(width: 5,),
              Container(
                height: 1,
                width: w * .27,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(3)
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
              Get.offAll(BottomView());
            },
            child: Container(
              height: h * .06,
              width: w * .9,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: h * .02,
                    width: w * .05,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/guest.png'),
                        )
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text('Continue As Guest',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('By continuing, you agree to our',style: TextStyle(color: Colors.grey,fontSize: 12),),
              SizedBox(width: 5,),
              Text(
                'Terms & Conditions',style: TextStyle(decoration: TextDecoration.underline,
                  color: Colors.black,fontSize: 13),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('and',style: TextStyle(color: Colors.grey,fontSize: 12),),
              SizedBox(width: 5,),
              Text(
                'Privacy Policy.',style: TextStyle(decoration: TextDecoration.underline,
                  color: Colors.black,fontSize: 13),),
            ],
          )
        ],
      ),
    );
  }
}
