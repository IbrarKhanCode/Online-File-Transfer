import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_file_transfer/view/home/bottom_view.dart';

class SignInController extends GetxController{

  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxBool isLoadingTwo = false.obs;
  final user = FirebaseAuth.instance.currentUser;


  Future<void> googleSignIn() async {
    isLoading.value = true;
    try{

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if(googleUser == null){
        isLoading.value = false;
        Get.snackbar(
          'Cancelled',
          'Sign-in canceller by User',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          animationDuration: Duration(milliseconds: 300),
          duration: Duration(seconds: 2),
          borderRadius: 8,
          borderWidth: 2,
        );
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential? userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;
      if(user != null){
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email' : user.email,
          'name' : user.displayName,
          'photoUrl' : user.photoURL,
          'createAt' : DateTime.now(),
        },SetOptions(merge: true));
      }
      isLoading.value = false;
      Get.snackbar(
        'Congratulation',
        'You have Successfully signIn with Google',
        colorText: Colors.white,
        backgroundColor: Colors.green,
        animationDuration: Duration(milliseconds: 300),
        duration: Duration(seconds: 2),
        borderRadius: 8,
        borderWidth: 2,
      );
      Get.offAll(() => BottomView());

    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
        animationDuration: Duration(milliseconds: 300),
        duration: Duration(seconds: 2),
        borderRadius: 8,
        borderWidth: 2,
      );
    }
  }



  Future<void> updateName(String newName) async {

    if(newName.trim().isEmpty || user == null){
      Get.snackbar(
        'Error',
        'Name can not be empty',
        colorText: Colors.white,
        backgroundColor: Colors.red,
        animationDuration: Duration(milliseconds: 300),
        duration: Duration(seconds: 2),
        borderRadius: 8,
        borderWidth: 2,
      );
      return;
    }

    isLoading.value = true;

    try{

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        'name' : newName.trim(),
      });
      isLoading.value = false;
      Get.snackbar(
        'Congratulation',
        'You have Successfully updated the Name',
        colorText: Colors.white,
        backgroundColor: Colors.green,
        animationDuration: Duration(milliseconds: 300),
        duration: Duration(seconds: 2),
        borderRadius: 8,
        borderWidth: 2,
      );
    } catch(e){
      isLoading.value = false;
      Get.snackbar(
        'Error',
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
        animationDuration: Duration(milliseconds: 300),
        duration: Duration(seconds: 2),
        borderRadius: 8,
        borderWidth: 2,
      );
    }

  }
}