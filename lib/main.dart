import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_file_transfer/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
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
    return PopScope(
      canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if(didPop) return;
          bool shouldExit =  await showBottomSheet(context);
          if(shouldExit){
            SystemNavigator.pop();
          }
        },
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'Montserrat'
          ),
          home: SplashScreen(),
        ),
    );
  }
}

Future<bool> showBottomSheet(BuildContext context) async {
  bool shouldExit = false;
  await Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * .2,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [

          ],
        ),
      )
  );
  return shouldExit;
}
