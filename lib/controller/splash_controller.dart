import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SplashController extends GetxController{

  var currentSteps = 1.obs;
  final int totalSteps = 4;

  @override
  void onInit() {
    super.onInit();
    startProgress();
  }

  Future<bool> checkIfUserStillExists(User user) async {
    try {
      await user.reload();
      User? updatedUser = FirebaseAuth.instance.currentUser;

      if (updatedUser == null) return false;
      return true;
    } catch (e) {
      print('User no longer valid: $e');
      return false;
    }
  }

  Future<void> signOutUser() async {
    try {

      await FirebaseAuth.instance.signOut();

      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      await googleSignIn.disconnect();

      print('Successfully signed out and cleared Google cache.');
    } catch (e) {
      print('Sign-out error: $e');
    }
  }

  void startProgress() async {
    await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;

    for (int i = 1; i <= totalSteps; i++) {
      await Future.delayed(const Duration(seconds: 1));
      currentSteps.value = i;
    }

    if (user == null) {
      Get.offAllNamed('/SignInScreen');
    } else {
      bool exists = await checkIfUserStillExists(user);
      if (!exists) {
        await signOutUser();
       Get.offAllNamed('/SignInScreen');
      } else {
        Get.offAllNamed('/bottomViewScreen');
      }
    }
  }
}