import 'package:get/get.dart';
import 'package:online_file_transfer/main.dart';
import 'package:online_file_transfer/splash_screen.dart';
import 'package:online_file_transfer/view/auth/signin_screen.dart';
import 'package:online_file_transfer/view/home/bottom_view.dart';
import 'package:online_file_transfer/view/profile/account_setting.dart';
import 'package:online_file_transfer/view/profile/delete_screen.dart';
import 'package:online_file_transfer/view/profile/setting_screen.dart';

class AppRoutes{

static final pages = [

  GetPage(
     name: '/splashScreen',
     page: () => GlobalPopScope(child: SplashScreen())
  ),
  GetPage(
      name: '/SignInScreen',
      page: () => GlobalPopScope(child: SigninScreen())
  ),
  GetPage(
      name: '/bottomViewScreen',
      page: () => GlobalPopScope(child: BottomView())
  ),
  GetPage(
      name: '/settingScreen',
      page: () => GlobalPopScope(child: SettingScreen())
  ),
  GetPage(
      name: '/accountSetting',
      page: () => GlobalPopScope(child: AccountSetting())
  ),
  GetPage(
      name: '/deleteScreen',
      page: () => GlobalPopScope(child: DeleteScreen())
  ),

];
}