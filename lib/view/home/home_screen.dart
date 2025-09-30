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

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          SizedBox(height: h * .07,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
              Container(
              height: h * .03,
              width: w * .05,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/side_bar.png'),
                  )
              ),
            ),
                SizedBox(width: 20,),
                Text('APP LOGO',style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.w700,fontSize: 20),),
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
              ],
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
                      fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.search,color: Colors.grey,),
                        hintStyle: TextStyle(color: Colors.grey,fontSize: 14,fontWeight: FontWeight.w400),
                        hintText: 'Search Here',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
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
          Divider(
            color: Colors.grey,
          ),
          Obx((){
            return Column(
              children: [
                if(controller.isListView.value)
                  SizedBox(
                    height: h * .6,
                    width: w,
                    child: ListView.builder(
                      itemCount: 4,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
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
                                        Text('File Name',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14),),
                                        Text('20-05-2024   20 Days Left',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 11),),
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

                if(!controller.isListView.value)
                  Center(child: Text('GridView'),),





                // Container(
                //   height: h * .07,
                //   width: w * .2,
                //   decoration: BoxDecoration(
                //       image: DecorationImage(image: AssetImage('assets/images/file.png'))
                //   ),
                // ),
                // SizedBox(height: 5,),
                // Text('No Data Found',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontSize: 10),),

              ],
            );
          }),
          SizedBox(height: h * .1,),
          GestureDetector(
            onTap: (){},
            child: Container(
              height: h * .06,
              width: w * .9,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add,color: Colors.white,),
                  SizedBox(width: 10,),
                  Text('Upload File',style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w600),)
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
