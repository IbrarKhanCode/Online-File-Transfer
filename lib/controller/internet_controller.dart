
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:online_file_transfer/core/utilis/app_colors.dart';

class InternetController extends GetxController{
  var isConnected = true.obs;
  late StreamSubscription<ConnectivityResult> _subscription;

  @override
  void onInit() {
    super.onInit();
    _listenConnectionChanges();
    WidgetsBinding.instance.addPostFrameCallback((_){
      _checkConnection();
    });
  }

  Future<void> _checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    isConnected.value = result != ConnectivityResult.none;
    if(!isConnected.value && Get.context != null){
      _showInternetSheet(Get.context!);
    }
  }

  void _listenConnectionChanges() {
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      bool newStatus = result != ConnectivityResult.none;

      if (newStatus != isConnected.value) {
        isConnected.value = newStatus;

        if (!isConnected.value) {
          _showInternetSheet(Get.context!);
        } else {
          if (Navigator.canPop(Get.context!)) {
            Navigator.pop(Get.context!);
          }
        }
      }
    });
  }

  void _showInternetSheet(BuildContext? context){
    final ctx = context ?? Get.overlayContext;
    if(ctx == null) return;

    showModalBottomSheet(
        backgroundColor: Colors.white,
        isDismissible: false,
        enableDrag: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        context: ctx,
        builder: (_){
          return SizedBox(
            height: MediaQuery.of(ctx).size.height * .3,
            width: MediaQuery.of(ctx).size.width,
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
                            height: MediaQuery.of(ctx).size.height * .03,
                            width: MediaQuery.of(ctx).size.width * .08,
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
                        height: MediaQuery.of(ctx).size.height* .085,
                        width: MediaQuery.of(ctx).size.width * .2,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: Image.asset(
                            height: MediaQuery.of(ctx).size.height * .05,
                            width: MediaQuery.of(ctx).size.width * .12,
                            'assets/images/internet.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Text('No Internet !',style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.w700,fontSize: 20,),),
                SizedBox(height: 5,),
                Text(
                  textAlign: TextAlign.center,
                  'You have lost internet connection !\n'
                  'Connect to internet.',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500),),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () async {
                    await _checkConnection();
                    if(isConnected.value){
                      if (Navigator.canPop(ctx)) Navigator.pop(ctx);
                    } else {
                      Get.snackbar(
                        'Connection Failed',
                        'No connection detected.Try again later',
                        colorText: Colors.white,
                        backgroundColor: Colors.red,
                        animationDuration: Duration(milliseconds: 300),
                        duration: Duration(seconds: 2),
                        borderRadius: 8,
                        borderWidth: 2,
                      );
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(ctx).size.height * .05,
                    width: MediaQuery.of(ctx).size.width * .9,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(child: Text('Try Again',
                      style: TextStyle(color: Colors.white,
                          fontSize: 16,fontWeight: FontWeight.w600),),),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }

}