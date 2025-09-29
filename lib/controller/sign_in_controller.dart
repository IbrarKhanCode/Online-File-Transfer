import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:online_file_transfer/view/home/home_screen.dart';

class SignInController extends GetxController{

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> googleSignIn() async {

    try{
      await auth.signOut();
      GoogleSignIn().signOut();
      await Future.delayed(Duration(milliseconds: 300));

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if(googleUser == null){
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
          'createAt' : DateTime.now(),
        }); SetOptions(merge: true);
      }
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
      Get.offAll(HomeScreen());

    } catch (e) {
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