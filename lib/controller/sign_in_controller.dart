import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController{

  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;
  RxBool isLoadingTwo = false.obs;
  RxBool isLoadingThree = false.obs;
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
      Get.offAllNamed('/bottomViewScreen');

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

  Future<void> signOutUser() async {
    isLoadingThree.value = true;
    try {

      final FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final bool isGoogleSignIn = await googleSignIn.isSignedIn();
      final bool isFirebaseUserSignedIn = auth.currentUser != null;

      if(!isFirebaseUserSignedIn && !isGoogleSignIn){
        isLoadingThree.value = false;
        Get.snackbar(
          'Notice',
          'You have already Logged out',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          animationDuration: Duration(milliseconds: 300),
          duration: Duration(seconds: 2),
          borderRadius: 8,
          borderWidth: 2,
        );
        return;
      }
      await auth.signOut();
      if(isGoogleSignIn){
        await googleSignIn.signOut();
      }
      isLoadingThree.value = false;
      Get.snackbar(
        'Congratulation',
        'You have Successfully signOut the Google Account',
        colorText: Colors.white,
        backgroundColor: Colors.green,
        animationDuration: Duration(milliseconds: 300),
        duration: Duration(seconds: 2),
        borderRadius: 8,
        borderWidth: 2,
      );
      Get.offAllNamed('/SignInScreen');
    } catch (e) {
      isLoadingThree.value = false;
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