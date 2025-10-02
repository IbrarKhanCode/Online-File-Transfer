import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_file_transfer/controller/home_controller.dart';
import 'package:online_file_transfer/core/utilis/app_colors.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {

  final user = FirebaseAuth.instance.currentUser;
  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: h * .08,
              width: w,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    SizedBox(height: h * .02,),
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
        
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
                builder: (context,snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if(!snapshot.hasData || !snapshot.data!.exists){
                    return Column(
                      children: [
                        Container(
                          height: h * .08,
                          width: w * .17,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/images/profileTwo.png')),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Name : User has not signup',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                        Text('Gmail : User has not signup',
                          style: TextStyle(color: Colors.grey,
                              fontWeight: FontWeight.w500,fontSize: 12),),
                      ],
                    );
                  }
                  var userData = snapshot.data!.data() as Map<String, dynamic>?;
                  if(userData == null || userData.isEmpty){
                    return Column(
                      children: [
                        Container(
                          height: h * .08,
                          width: w * .17,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/images/profileTwo.png')),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text('Name : User has not signup',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                        Text('Gmail : User has not signup',
                          style: TextStyle(color: Colors.grey,
                              fontWeight: FontWeight.w500,fontSize: 12),),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(userData['photoUrl']),
                        radius: 40,
                      ),
                      SizedBox(height: 10,),
                      Text(userData['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14),),
                      Text(userData['email'],
                        style: TextStyle(color: Colors.grey,
                            fontWeight: FontWeight.w500,fontSize: 12),),
                    ],
                  );
                }),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Full Name',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 12),),
        
                    ],
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    controller: controller.nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your full name',
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 12,fontWeight: FontWeight.w500),
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
                      Text('Language',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 12),),
        
                    ],
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Select Language',
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 12,fontWeight: FontWeight.w500),
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
                          Text('Account ID',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 12),),
                          Spacer(),
                          Text('000000000',style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.w500,fontSize: 12),),
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
                          Text('Registration Date',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 12),),
                          Spacer(),
                          Text('09-12-2024',style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.w500,fontSize: 12),),
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
                          Text('Last Login',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 12),),
                          Spacer(),
                          Text('17-07-2025',style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.w500,fontSize: 12),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: h * .17,),
                  GestureDetector(
                    onTap: (){
        
                    },
                    child: Container(
                      height: h * .05,
                      width: w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(child: Text('Save Changes',style: TextStyle(color: Colors.white,
                          fontSize: 14,fontWeight: FontWeight.w600),),),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
