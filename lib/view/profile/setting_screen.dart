import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: h * .13,
            width: w,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(height: h * .05,),
                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            Get.back();
                          },
                          icon: Icon(Icons.arrow_back)),
                      Text('Settings',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            height: h * .08,
            width: w * .17,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/profileTwo.png')),
            ),
          ),
          SizedBox(height: 10,),
          Text('Mark Jonson',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14),),
          StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
              builder: (context,snapshot){
                if(!snapshot.hasData || !snapshot.data!.exists){
                  return Center(child: Text('User has not Signup'),);
                }
                var userData = snapshot.data!.data() as Map<String, dynamic>?;
                if(userData == null || userData.isEmpty){
                  return Center(child: Text('User has not Signup'),);
                }
                return Text(userData['email'],
                  style: TextStyle(color: Colors.grey,
                      fontWeight: FontWeight.w500,fontSize: 12),);
              }),
          SizedBox(height: 20,),
          Container(
            height: h * .07,
            width: w * .9,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade100,),
              borderRadius: BorderRadius.circular(15)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: h * .035,
                    width: w * .08,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                          image: AssetImage('assets/images/account.png'))
                    ),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Account Settings',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600),),
                      Text('Edit your profile',style: TextStyle(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.w400),),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: h * .07,
            width: w * .9,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade100,),
                borderRadius: BorderRadius.circular(15)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: h * .03,
                    width: w * .08,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/premium.png'))
                    ),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Premium',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600),),
                      Text('Explore premium packages',style: TextStyle(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.w400),),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: h * .07,
            width: w * .9,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade100,),
                borderRadius: BorderRadius.circular(15)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: h * .03,
                    width: w * .08,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/images/delete.png'))
                    ),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Deleted Files',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w600),),
                      Text('Check your industry ',style: TextStyle(color: Colors.grey,fontSize: 10,fontWeight: FontWeight.w400),),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            height: h * .07,
            width: w * .9,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade100,),
                borderRadius: BorderRadius.circular(15)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Container(
                    height: h * .035,
                    width: w * .08,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/images/logout.png'))
                    ),
                  ),
                  SizedBox(width: 15,),
                  Text('Logout',style: TextStyle(color: Colors.red,fontSize: 14,fontWeight: FontWeight.w600),),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
