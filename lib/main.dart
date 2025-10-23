import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_file_transfer/core/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:online_file_transfer/core/utilis/app_colors.dart';
import 'firebase_options.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Montserrat'
      ),
      initialRoute: '/splashScreen',
     getPages: AppRoutes.pages,
    );
  }
}

class GlobalPopScope extends StatelessWidget {
  final Widget child;
  const GlobalPopScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if(didPop) return;
          bool shouldExit =  await exitSheet(context);
          if(shouldExit){
            SystemNavigator.pop();
          }
        },
        child: child,
    );
  }
}


Future<bool> exitSheet(BuildContext context) async {
  bool shouldExit = false;

  await showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      context: context,
      builder: (context){
        return SizedBox(
          height: MediaQuery.of(context).size.height * .37,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(height: 20,),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15,),
                      child: GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .03,
                          width: MediaQuery.of(context).size.width * .08,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(Icons.close,color: Colors.black,size: 20,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * .085,
                      width: MediaQuery.of(context).size.width * .2,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(child: Image.asset(
                          height: MediaQuery.of(context).size.height * .05,
                          width: MediaQuery.of(context).size.width * .12,
                          'assets/images/exit.png'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Text('Exit App',style: TextStyle(color: Colors.black,
                fontWeight: FontWeight.w700,fontSize: 20,),),
              SizedBox(height: 5,),
              Text(
                textAlign: TextAlign.center,
                'Are you sure that you want\n'
                'exit app ?',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  shouldExit = true;
                  Get.back();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * .05,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: Text('YES',
                    style: TextStyle(color: Colors.white,
                        fontSize: 16,fontWeight: FontWeight.w600),),),
                ),
              ),
              SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  shouldExit = false;
                  Get.back();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * .05,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(child: Text('NO',
                    style: TextStyle(color: AppColors.primaryColor,
                      fontSize: 16,fontWeight: FontWeight.w700,),),),
                ),
              ),
            ],
          ),
        );
      }
  );
  return shouldExit;
}
