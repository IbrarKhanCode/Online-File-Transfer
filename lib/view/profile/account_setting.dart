import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_file_transfer/controller/home_controller.dart';
import 'package:online_file_transfer/controller/sign_in_controller.dart';
import 'package:online_file_transfer/core/utilis/app_colors.dart';
import 'package:online_file_transfer/core/widget/user_data_column.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {

  final user = FirebaseAuth.instance.currentUser;
  final controller = Get.put(HomeController());
  final signInController = Get.put(SignInController());
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: h * .07,
                    width: w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        children: [
                          SizedBox(height: h * .01,),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: (){
                                    Get.back();
                                  },
                                  icon: Icon(Icons.arrow_back)),
                              Text('Account Settings',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  if(user == null)...[
                    UserDataColumn(),
                  ]
                  else ...[
                    StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
                        builder: (context,snapshot){
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ));
                          }
                          if(!snapshot.hasData || !snapshot.data!.exists){
                            return UserDataColumn();
                          }
                          var userData = snapshot.data!.data() as Map<String, dynamic>?;

                          if(userData == null || userData.isEmpty){
                            return UserDataColumn();
                          }
                          return Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: userData['photoUrl'] != null ?
                                NetworkImage(userData['photoUrl']) : AssetImage('assets/images/profileTwo.png'),
                                radius: 40,
                              ),
                              SizedBox(height: 10,),
                              Text(userData['name'] ?? 'Name',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                              Text(userData['email'] ?? 'Gmail',
                                style: TextStyle(color: Colors.grey,
                                    fontWeight: FontWeight.w500,fontSize: 12),),
                            ],
                          );
                        }),
                  ],
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Full Name',style: TextStyle(color: Color(0xff666666),
                                fontWeight: FontWeight.w600,fontSize: 13),),
              
                          ],
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                              hintText: 'Enter your full name',
                              hintStyle: TextStyle(color: Colors.grey,fontSize: 13,
                                  fontWeight: FontWeight.w500),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey.shade100)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: AppColors.primaryColor)
                              )
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text('Language',style: TextStyle(color: Color(0xff666666),
                                fontWeight: FontWeight.w600,fontSize: 13),),
              
                          ],
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Select Language',
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 13,
                                fontWeight: FontWeight.w500),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.grey.shade100)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: AppColors.primaryColor)
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: h * .06,
                          width: w,
                          decoration: BoxDecoration(
                              color: Color(0xffF8F8F8),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text('Account ID',style: TextStyle(color: Colors.grey,
                                    fontWeight: FontWeight.w500,fontSize: 13),),
                                Spacer(),
                                Text('000000000',style: TextStyle(color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w500,fontSize: 13),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: h * .06,
                          width: w,
                          decoration: BoxDecoration(
                              color: Color(0xffF8F8F8),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text('Registration Date',style: TextStyle(color: Colors.grey,
                                    fontWeight: FontWeight.w500,fontSize: 13),),
                                Spacer(),
                                Text('09-12-2024',style: TextStyle(color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w500,fontSize: 13),),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: h * .06,
                          width: w,
                          decoration: BoxDecoration(
                              color: Color(0xffF8F8F8),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Text('Last Login',style: TextStyle(color: Colors.grey,
                                    fontWeight: FontWeight.w500,fontSize: 13),),
                                Spacer(),
                                Text('17-07-2025',style: TextStyle(color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w500,fontSize: 13),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Obx((){
                    return signInController.isLoading.value ?
                    CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ) :
                    GestureDetector(
                      onTap: ()  {
                        signInController.updateName(nameController.text);
                      },
                      child: Container(
                        height: h * .05,
                        width: w * .9,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(child: Text('Save Changes',style: TextStyle(color: Colors.white,
                            fontSize: 14,fontWeight: FontWeight.w600),),),
                      ),
                    );
                  })
                )
            )
          ],
        )
      ),
    );
  }
}
