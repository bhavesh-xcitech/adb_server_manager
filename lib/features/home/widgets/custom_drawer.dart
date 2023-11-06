import 'package:adb_server_manager/common_widgets/app_gap_height.dart';
import 'package:adb_server_manager/common_widgets/app_gap_width.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/app_images.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CustomDrawer extends StatelessWidget {
  final String phoneNumber;
  final bool isNotificationEnabled;
  final FormzStatus addUserFormzStatus;
  final PackageInfo packageInfo;
  final Function onChange;

  const CustomDrawer(
      {super.key,
      required this.phoneNumber,
      required this.isNotificationEnabled,
      required this.packageInfo,
      required this.onChange,
      this.addUserFormzStatus = FormzStatus.pure});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.backgroundColor,
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              color: AppColors.secondaryColor,
              child: Stack(
                children: [
                  SizedBox(
                      height: 200,
                      child: Center(
                          child: Lottie.asset('assets/settings.json',
                              repeat: false))),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GoogleText(
                          text: packageInfo.appName,
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          // textColor: AppColors.backgroundColor,
                        ),
                        const GapH(10),
                        GoogleText(
                          text: phoneNumber.toString(),
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          // textColor: AppColors.backgroundColor,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_active,
                        color: isNotificationEnabled
                            ? AppColors.decorationColor
                            : Colors.white,
                        size: 19,
                      ),
                      const GapW(8),
                      const GoogleText(
                        text: "Notifications",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      const Spacer(),
                      if (addUserFormzStatus.isSubmissionInProgress) ...[
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator.adaptive(
                                strokeWidth: 2,
                              )),
                        )
                      ] else ...[
                        Switch(
                          value: isNotificationEnabled,
                          onChanged: (value) => onChange(value),
                          activeColor: AppColors.decorationColor,
                          activeTrackColor: AppColors.btnColor,
                          inactiveTrackColor: Colors.white,
                          inactiveThumbColor: AppColors.decorationColor,
                        ),
                      ]
                    ],
                  ),
                ],
              ),
            ),
            const GapH(15),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: GoogleText(
                text: "Version ${packageInfo.version}",
                fontSize: 12,
              )),
            ),
            const GoogleText(
              text: AppStrings.proudlyDevelopedBy,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Center(
                child: Image.asset(
                  AppImages.xcitechLogo,
                  height: 60,
                  width: 100,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
