import 'package:adb_server_manager/resource/app_images.dart';
import 'package:adb_server_manager/resource/shared_pref.dart';
import 'package:adb_server_manager/routers/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    redirect();
    //  context.push(AppRouteNames.home);
    // FlutterNativeSplash.remove();
    super.initState();
  }

  void redirect() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isLoggedIn = await SharedPref.getLoggedIn();

    if (mounted) {
      if (isLoggedIn) {
        context.go(AppRouteNames.home);
      } else {
        context.go(AppRouteNames.logIn);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              AppImages.logo,
              scale: 5,
            )),
          ]),
    );
  }
}
