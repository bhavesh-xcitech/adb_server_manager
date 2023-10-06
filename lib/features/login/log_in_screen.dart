import 'package:adb_server_manager/common_widgets/app_bar.dart';
import 'package:adb_server_manager/common_widgets/app_button.dart';
import 'package:adb_server_manager/common_widgets/app_gap_height.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/common_widgets/app_textfild.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:adb_server_manager/routers/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CommonAppBar(text: AppStrings.logIn, isNeedBackBtn: false),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: AppColors.secondaryBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GoogleText(
                    text: AppStrings.hello,
                    fontSize: 17,
                  ),
                  const GoogleText(
                    text: AppStrings.welcomeBack,
                    fontSize: 15,
                  ),
                  const GapH(10),
                  AppBorderTextFormField(
                    controller: emailController,
                    hintText: AppStrings.email,
                  ),
                  const GapH(10),
                  AppBorderTextFormField(
                    controller: passController,
                    hintText: AppStrings.password,
                  ),
                  const GapH(20),
                  AppCommonButton(
                      onTap: () {
                        context.pushReplacement(AppRouteNames.serverListing);
                      },
                      text: AppStrings.logIn),
                  Row(
                    children: [
                      const GoogleText(
                        text: AppStrings.doNotHaveAccount,
                        fontSize: 12,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: const GoogleText(
                            text: AppStrings.register,
                            textColor: Colors.blue,
                          ))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
