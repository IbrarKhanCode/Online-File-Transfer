import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_file_transfer/controller/home_controller.dart';
import 'package:online_file_transfer/core/utilis/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final controller = Get.put(HomeController());
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: h * .09,
                width: w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      SizedBox(height: h * .02,),
                      Row(
                        children: [
                          Container(
                            height: h * .033,
                            width: w * .12,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/images/logo.png'),
                                )
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text('Online File Transfer',style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.w600,fontSize: 16),),
                          Spacer(),
                          Container(
                            height: h * .05,
                            width: w * .13,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Stack(
                                children: [
                                  Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: h * .03,
                                        width: w * .05,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: AssetImage('assets/images/notification.png'))
                                        ),
                                      )),
                                  Positioned(
                                    left: 29,
                                    top: 12,
                                    child: Badge(
                                      backgroundColor: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10,),
                          if(user == null)...[
                            GestureDetector(
                              onTap: (){
                                Get.toNamed('/settingScreen');
                              },
                              child: Container(
                                height: h * .052,
                                width: w * .12,
                                decoration: BoxDecoration(
                                  image: DecorationImage(image: AssetImage('assets/images/profile.png')),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ]
                          else...[
                            StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
                                builder: (context, snapshot){
                                  if(snapshot.connectionState == ConnectionState.waiting){
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                      ),
                                    );
                                  }
                                  if(!snapshot.hasData || !snapshot.data!.exists){
                                    return GestureDetector(
                                      onTap: (){
                                        Get.toNamed('/settingScreen');
                                      },
                                      child: Container(
                                        height: h * .052,
                                        width: w * .12,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: AssetImage('assets/images/profile.png')),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    );
                                  }
                                  var data = snapshot.data!.data() as Map<String, dynamic>?;
                                  if(data == null || data.isEmpty){
                                    return GestureDetector(
                                      onTap: (){
                                        Get.toNamed('/settingScreen');
                                      },
                                      child: Container(
                                        height: h * .052,
                                        width: w * .12,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: AssetImage('assets/images/profile.png')),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    );
                                  }
                                  return GestureDetector(
                                    onTap: (){
                                      Get.toNamed('/settingScreen');
                                    },
                                    child: CircleAvatar(
                                      backgroundImage: data['photoUrl'] != null ?
                                      NetworkImage(data['photoUrl']) : AssetImage('assets/images/profileTwo.png'),
                                      radius: 20,
                                    ),
                                  );
                                }
                            )
                          ]
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child:  Row(
                  children: [
                    SizedBox(
                      width: w * .84,
                      height: h * .05,
                      child: TextField(
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                            filled: true,
                            prefixIcon: Icon(Icons.search,color: Colors.grey,),
                            hintStyle: TextStyle(color: Colors.grey,fontSize: 14,
                                fontWeight: FontWeight.w500),
                            hintText: 'Search Here',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: AppColors.primaryColor),
                            )
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: (){
                        controller.toggleView();
                      },
                      child: Obx((){
                        return Container(
                          height: h * .03,
                          width: w * .07,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: controller.isListView.value ? AssetImage('assets/images/grid.png')
                                      : AssetImage('assets/images/list.png'),
                              )
                          ),
                        );
                      })
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Obx((){
                return Column(
                  children: [
                    if(controller.isListView.value && controller.files.isNotEmpty)
                      SizedBox(
                        height: h * .71,
                        width: w,
                        child: ListView.builder(
                          itemCount: controller.fileName.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context,index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                child: Container(
                                  height: h * .1,
                                  width: w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: h * .07,
                                          width: w * .15,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                        ),
                                        SizedBox(width: 20,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                          SizedBox(
                                            width : w * .55,
                                            child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              controller.fileName[index],
                                            style: TextStyle(color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                                                                  ),
                                          ),
                                            Row(
                                              children: [
                                                Text('20-05-2024',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 11),),
                                                SizedBox(width: 10,),
                                                Text('20-05-2024',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 11),),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_forward_ios,color: Colors.grey,)
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),

                    if(!controller.isListView.value && controller.files.isNotEmpty)
                      SizedBox(
                        height: h * .715,
                        width: w,
                        child: GridView.builder(
                          itemCount: controller.fileName.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                              mainAxisExtent: 170,
                            ),
                            itemBuilder: (context,index){
                             return Column(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                 Container(
                                   height: h * .12,
                                   width: w * .27,
                                   decoration: BoxDecoration(
                                       color: Colors.white,
                                       borderRadius: BorderRadius.circular(10),
                                   ),
                                 ),
                                 SizedBox(height: 10,),
                                 Padding(
                                   padding: const EdgeInsets.symmetric(horizontal: 15),
                                   child: SizedBox(
                                     height : h * .025,
                                     child: Text(
                                       textAlign: TextAlign.center,
                                       overflow: TextOverflow.ellipsis,
                                       maxLines: 1,
                                       controller.fileName[index],
                                       style: TextStyle(color: Colors.black,
                                           fontSize: 14,
                                           fontWeight: FontWeight.w500),
                                     ),
                                   ),
                                 ),
                                 Text('20-05-2024',style: TextStyle(color: Colors.grey,fontSize: 11,fontWeight: FontWeight.w400),),
                               ],
                             );
                            }),
                      ),
                    if(controller.files.isEmpty)...[
                      SizedBox(height: h * .27,),
                      Container(
                        height: h * .07,
                        width: w * .2,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/file.png')),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text('No Data Found',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 10),),
                      SizedBox(height: h * .15,),
                    ],
                  ],
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: RawMaterialButton(
          fillColor: AppColors.primaryColor,
          shape: CircleBorder(),
          constraints:  BoxConstraints.tightFor(
            width: 80.0,
            height: 80.0,
          ),
          child: Icon(Icons.add,color: Colors.white,size: 40,),
          onPressed: (){
            controller.pickFiles();
          }
      ),
    );
  }
}
