import 'package:adb_server_manager/common_widgets/app_button.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:flutter/material.dart';

class DiffDialogs {
  static notificationOffDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5,
          backgroundColor: AppColors.backgroundColor,
          title: Row(
            children: const [GoogleText(text: 'ABOUT NOTIFICATION'), Spacer()],
          ),
          content: const GoogleText(
              text: "Your action will be implemented after a few seconds."),
          actions: <Widget>[
            AppCommonButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
                text: "ok")
          ],
        );
      },
    );
  }

  static notificationToggleFail(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 5,
            backgroundColor: AppColors.backgroundColor,
            title: Row(
              children: const [
                GoogleText(text: 'ABOUT NOTIFICATION'),
                Spacer()
              ],
            ),
            content: const GoogleText(
                text: "for some reasons your action is not implemented"),
            actions: <Widget>[
              AppCommonButton(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  text: "ok")
            ],
          );
        });
  }
}
