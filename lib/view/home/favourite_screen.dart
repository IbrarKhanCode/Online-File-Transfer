import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_file_transfer/controller/home_controller.dart';
import 'package:online_file_transfer/core/utilis/app_colors.dart';
import 'package:online_file_transfer/view/profile/setting_screen.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: h * .11,
            width: w,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(height: h * .05,),
                  Row(
                    children: [
                      Container(
                        height: h * .04,
                        width: w * .09,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                            )
                        ),
                      ),
                      SizedBox(width: 10,),
                      Text('Favorite',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 16),),
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
                                  child: Icon(Icons.notifications_none,color: Colors.black,)),
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
                      GestureDetector(
                        onTap: (){
                          Get.to(SettingScreen());
                        },
                        child: Container(
                          height: h * .05,
                          width: w * .1,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage('assets/images/profile.png')),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:  Row(
              children: [
                SizedBox(
                  width: w * .8,
                  height: h * .05,
                  child: TextField(
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        prefixIcon: Icon(Icons.search,color: Colors.grey,),
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400),
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
                SizedBox(width: 15,),
                GestureDetector(
                    onTap: (){
                      controller.toggleView();
                    },
                    child: Obx((){
                      return Container(
                        height: h * .03,
                        width: w * .05,
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
                    height: h * .65,
                    width: w,
                    child: ListView.builder(
                        itemCount: controller.fileName.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
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
                                        Obx((){
                                          return Text(controller.fileName[index],
                                            style: TextStyle(color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          );
                                        }),
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
                    height: h * .65,
                    width: w,
                    child: GridView.builder(
                        itemCount: controller.fileName.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.6,
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
                                child: Text(
                                  textAlign: TextAlign.center,
                                  controller.fileName[index],
                                  style: TextStyle(color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
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
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          shape: CircleBorder(),
          child: Icon(Icons.add,color: Colors.white,),
          onPressed: (){
            controller.pickFiles();
          }
      ),
    );
  }
}
