import 'package:adb_server_manager/common_widgets/app_button.dart';
import 'package:adb_server_manager/common_widgets/app_gap_height.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/common_widgets/app_textfild.dart';
import 'package:adb_server_manager/common_widgets/custopm_top_snackbar.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/app_images.dart';
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
  TextEditingController userNameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(AppImages.logo))),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: AppColors.secondaryBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GoogleText(
                      text: AppStrings.hello,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    const GoogleText(
                      text: AppStrings.welcomeBack,
                      fontSize: 15,
                    ),
                    const GapH(10),
                    AppBorderTextFormField(
                      validator: (String? value) {
                        if (value == null || value.trim() == '') {
                          return AppStrings.usernameIsRequired;
                        }

                        return null;
                      },
                      controller: userNameController,
                      hintText: AppStrings.userName,
                    ),
                    const GapH(10),
                    AppBorderTextFormField(
                      controller: passController,
                      hintText: AppStrings.password,
                      validator: (String? value) {
                        if (value == null || value.trim() == '') {
                          return AppStrings.passwordIsRequired;
                        }

                        return null;
                      },
                    ),
                    const GapH(20),
                    AppCommonButton(
                        onTap: () {
                          bool isValidate = _formKey.currentState!.validate();
                          if (isValidate) {
                            if (userNameController.text == "server" &&
                                passController.text == "P@ssw0rd") {
                              context
                                  .pushReplacement(AppRouteNames.serverListing);
                            } else {
                              CustomSnackBar.show(
                                  context: context,
                                  message: "invalid username/password!");
                            }
                          }
                        },
                        text: AppStrings.logIn),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
