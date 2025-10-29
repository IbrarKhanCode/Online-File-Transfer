import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_file_transfer/controller/home_controller.dart';
import 'package:online_file_transfer/core/utilis/app_colors.dart';
import 'package:online_file_transfer/core/widget/custom_container.dart';
import 'package:online_file_transfer/core/widget/user_profile.dart';

class MyFilesScreen extends StatefulWidget {
  const MyFilesScreen({super.key});

  @override
  State<MyFilesScreen> createState() => _MyFilesScreenState();
}

class _MyFilesScreenState extends State<MyFilesScreen> {

  final controller = Get.put(HomeController());
  final user = FirebaseAuth.instance.currentUser;

  void openDialog(BuildContext context,HomeController controller,PlatformFile file){
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.white,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () async {
                            Get.back();
                            await controller.shareFile(file);
                          },
                          child: Text(controller.isShared(file) ? 'Reshare'
                          : 'Share')),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: (){
                            controller.toggleFavourite(file);
                            Get.back();
                          },
                          child: Text(controller.isFavourite(file) ? 'unFavourite'
                              : 'Favourite'))
                    ],
                  ),
                ),
              ),
            );
          });
  }

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
                height: h * .08,
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
                            height: h * .03,
                            width: w * .1,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage('assets/images/logo.png'),
                                )
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text('My Files',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),),
                          Spacer(),
                          Container(
                            height: h * .04,
                            width: w * .1,
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
                                        height: h * .02,
                                        width: w * .04,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(image: AssetImage('assets/images/notification.png'))
                                        ),
                                      )),
                                  Positioned(
                                    left: 23,
                                    top: 10,
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
                            UserProfile(),
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
                                    return UserProfile();
                                  }
                                  var data = snapshot.data!.data() as Map<String, dynamic>?;
                                  if(data == null || data.isEmpty){
                                    return UserProfile();
                                  }
                                  return GestureDetector(
                                    onTap: (){
                                      Get.toNamed('/settingScreen');
                                    },
                                    child: CircleAvatar(
                                      backgroundImage: data['photoUrl'] != null ?
                                      NetworkImage(data['photoUrl']) : AssetImage('assets/images/profileTwo.png'),
                                      radius: 22,
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
                        onChanged: controller.filterFiles,
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
                                  fit: BoxFit.contain,
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
                    if(controller.isListView.value && controller.platformFiles.isNotEmpty)
                      SizedBox(
                        height: h * .71,
                        width: w,
                        child: ListView.builder(
                            itemCount: controller.filteredFiles.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context,index){
                              final file = controller.filteredFiles[index];
                              final extension = file.extension?.toLowerCase() ?? '';

                              Widget preview;
                              if(['png','jpg','jpeg'].contains(extension)){
                                preview = Container(
                                  height: h * .07,
                                  width: w * .15,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                        image: FileImage(File(file.path!))),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                );
                              }
                              else if(['mp4','mkv','avi'].contains(extension)){
                                preview = CustomContainer(image: 'assets/images/logo.png');
                              }
                              else if(['mp3','wav'].contains(extension)){
                                preview = CustomContainer(image: 'assets/images/audio.png');
                              }
                              else if(extension == 'pdf'){
                                preview = CustomContainer(image: 'assets/images/pdf.png');
                              }
                              else if(['doc','docx'].contains(extension)){
                                preview = CustomContainer(image: 'assets/images/word.png');
                              }
                              else if(extension == 'zip'){
                                preview = CustomContainer(image: 'assets/images/zip.png');
                              }
                              else{
                                preview = CustomContainer(image: 'assets/images/unselected_files.png');
                              }
        
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                                child: Container(
                                  height: h * .1,
                                  width: w,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        preview,
                                        SizedBox(width: 20,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width : w * .55,
                                              child: Text(file.name,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
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
        
                    if(!controller.isListView.value && controller.platformFiles.isNotEmpty)
                      SizedBox(
                        height: h * .715,
                        width: w,
                        child: GridView.builder(
                          padding: EdgeInsets.only(top: 10),
                            itemCount: controller.filteredFiles.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                              mainAxisExtent: 170,
                            ),
                            itemBuilder: (context,index){
                              final file = controller.filteredFiles[index];
                              final extension = file.extension?.toLowerCase() ?? '';
                              Widget preview;
                              if(['png','jpg','jpeg'].contains(extension)){
                                preview = Container(
                                  height: h * .12,
                                  width: w * .27,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(File(file.path!))),
                                      borderRadius: BorderRadius.circular(8),
                                  ),
                                );
                              }
                              else if(['mp4','mkv','avi'].contains(extension)){
                                preview = CustomContainer(image: 'assets/images/logo.png');
                              }
                              else if(['mp3','wav'].contains(extension)){
                                preview = CustomContainer(image: 'assets/images/audio.png');
                              }
                              else if(extension == 'pdf'){
                                preview = CustomContainer(image:  'assets/images/pdf.png');
                              }
                              else if(['doc','docx'].contains(extension)){
                                preview = CustomContainer(image:  'assets/images/word.png');
                              }
                              else if(extension == 'zip'){
                                preview = CustomContainer(image:  'assets/images/zip.png');
                              }
                              else{
                                preview = CustomContainer(image:  'assets/images/unselected_files.png');
                              }
        
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: GestureDetector(
                                  onTap: (){
                                    openDialog(
                                        context,
                                        controller,
                                        file,
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: h * .12,
                                          width: w * .28,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Center(child: preview)),
                                      SizedBox(height: 10,),
                                      SizedBox(
                                        height : h * .025,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          file.name,
                                          style: TextStyle(color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Text('20-05-2024',style: TextStyle(color: Colors.grey,fontSize: 11,fontWeight: FontWeight.w400),),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    if(controller.platformFiles.isEmpty)...[
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
