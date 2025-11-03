import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_file_transfer/controller/home_controller.dart';
import 'package:online_file_transfer/core/utilis/app_colors.dart';
import 'package:online_file_transfer/core/widget/custom_container.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({super.key});

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  
  final controller = Get.put(HomeController());
  
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
                height: h * .07,
                width: w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  children: [
                    SizedBox(height: h * .01,),
                    Row(
                      children: [
                        SizedBox(width: 5,),
                        IconButton(
                            onPressed: (){
                              Get.back();
                            },
                            icon: Icon(Icons.arrow_back)
                        ),
                        Text('Delete Files',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),),
                      ],
                    ),
                  ],
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
                          controller.deleteToggleView();
                        },
                        child: Obx((){
                          return Container(
                            height: h * .03,
                            width: w * .07,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: controller.deleteListView.value ? AssetImage('assets/images/grid.png')
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
                    if(controller.deleteListView.value && controller.deleteFiles.isNotEmpty)
                      SizedBox(
                        height: h * .81,
                        width: w,
                        child: ListView.builder(
                            itemCount: controller.deleteFiles.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context,index){
                              final deleteFile = controller.deleteFiles[index];
                              final extension = deleteFile.extension?.toLowerCase() ?? '';
          
                              Widget preview;
                              if(['png','jpg','jpeg'].contains(extension)){
                                preview = Container(
                                  height: h * .07,
                                  width: w * .15,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(File(deleteFile.path!))),
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
                                      borderRadius: BorderRadius.circular(10)
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
                                              child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                deleteFile.name,
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
          
                    if(!controller.deleteListView.value && controller.deleteFiles.isNotEmpty)
                      SizedBox(
                        height: h * .8,
                        width: w,
                        child: GridView.builder(
                            padding: EdgeInsets.only(top: 10),
                            itemCount: controller.deleteFiles.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                              mainAxisExtent: 170,
                            ),
                            itemBuilder: (context,index){
                              final deleteFile = controller.deleteFiles[index];
                              final extension = deleteFile.extension?.toLowerCase() ?? '';
                              Widget preview;
                              if(['png','jpg','jpeg'].contains(extension)){
                                preview = Container(
                                  height: h * .12,
                                  width: w * .27,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(File(deleteFile.path!))),
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
                                        deleteFile.name,
                                        style: TextStyle(color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Text('20-05-2024',style: TextStyle(color: Colors.grey,fontSize: 11,fontWeight: FontWeight.w400),),
                                  ],
                                ),
                              );
                            }),
                      ),
                    if(controller.deleteFiles.isEmpty)...[
                      SizedBox(height: h * .28,),
                      Container(
                        height: h * .07,
                        width: w * .2,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage('assets/images/file.png')),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Text('No DeleteFile Found',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 10),),
                      SizedBox(height: h * .15,),
                    ],
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
