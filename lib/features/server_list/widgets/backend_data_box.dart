import 'package:adb_server_manager/common_widgets/app_gap_height.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/features/server_list/models/pm2_env_model.dart';
import 'package:adb_server_manager/features/server_list/widgets/double_text.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:adb_server_manager/routers/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class BackendDataBox extends StatelessWidget {
  const BackendDataBox({super.key, this.pm2Data, this.index});

  final PM2ProcessInfo? pm2Data;
  final int? index;
  String changeTimeFormate(milliseconds) {
    int timestamp = milliseconds; // Replace this with your actual timestamp

// Create a DateTime object from the timestamp
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

// Format the DateTime object as a string in your desired format
    String formattedDateTime =
        DateFormat('dd-MM-yyyy HH:mm:ss').format(dateTime);
    return formattedDateTime;
  }

  String bytesToMB(int? bytes) {
    double megabytes = (bytes ?? 0) / (1024 * 1024);
    return "${megabytes.toStringAsFixed(2)} MB";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRouteNames.backendDetails, extra: {
          'index': index ?? 0,
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.secondaryBackgroundColor,
          border: Border.all(
              color: pm2Data?.pm2Env?.status == "online"
                  ? AppColors.decorationColor
                  : AppColors.secondaryBackgroundColor.withOpacity(0.5),
              width: 2.5),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GoogleText(
              textAlign: TextAlign.end,
              text: pm2Data?.pm2Env?.status ?? "",
              textColor: pm2Data?.pm2Env?.status == "online"
                  ? AppColors.decorationColor
                  : Colors.red,
            ),
            const GapH(3),
            DoubleTextWidget(
              text1: AppStrings.name,
              text2: pm2Data?.name ?? "",
            ),
            DoubleTextWidget(
              text1: AppStrings.pId,
              text2: pm2Data?.pId.toString() ?? "",
            ),
            DoubleTextWidget(
                text1: AppStrings.upTime,
                text2: changeTimeFormate(pm2Data?.pm2Env?.pmUpTime ?? 0)),
            DoubleTextWidget(
              text1: AppStrings.createdAt,
              text2: changeTimeFormate(pm2Data?.pm2Env?.createdAt ?? 0),
            ),
            DoubleTextWidget(
              text1: AppStrings.nodeVersion,
              text2: pm2Data?.pm2Env?.nodeVersion ?? "",
            ),
            const GapH(10),
            const Align(
              alignment: Alignment.centerLeft,
              child: GoogleText(
                text: AppStrings.monitor,
                textAlign: TextAlign.start,
                textColor: Colors.white,
              ),
            ),
            const GapH(5),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  border: Border.all(color: AppColors.fillColor),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  DoubleTextWidget(
                      text1: AppStrings.memory,
                      text2: bytesToMB(pm2Data?.monitoring?.memory)),
                  DoubleTextWidget(
                      text1: AppStrings.cpu,
                      text2: pm2Data?.monitoring?.cpu.toString() ?? "")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
