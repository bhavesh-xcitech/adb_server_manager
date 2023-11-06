import 'package:adb_server_manager/common_widgets/app_gap_height.dart';
import 'package:adb_server_manager/common_widgets/app_gap_width.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/features/alert_logs/models/server_logs_model.dart';
import 'package:adb_server_manager/features/server_list/widgets/double_text.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/app_images.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AlertBoxWidget extends StatelessWidget {
  final AlertLogs logs;
  final int index;
  final bool isAnimate;
  const AlertBoxWidget(
      {super.key,
      required this.logs,
      required this.index,
      this.isAnimate = false});

  String formatTimeDifference(Duration difference) {
    if (difference.inDays > 0) {
      int days = difference.inDays;
      if (days == 1) {
        return '1 day ago';
      }
      return '$days days ago';
    } else if (difference.inHours > 0) {
      int hours = difference.inHours;
      if (hours == 1) {
        return '1 hour ago';
      }
      return '$hours hours ago';
    } else if (difference.inMinutes > 0) {
      int minutes = difference.inMinutes;
      if (minutes == 1) {
        return '1 minute ago';
      }
      return '$minutes minutes ago';
    } else if (difference.inSeconds > 0) {
      int seconds = difference.inSeconds;
      if (seconds == 1) {
        return '1 second ago';
      }
      return '$seconds seconds ago';
    } else {
      return 'just now';
    }
  }

  String timeDifference(timestampString) {
    // String timestampString = '2023-11-06 10:16:21.123Z';

    // Step 1: Parse the timestamp
    DateTime timestamp = DateTime.parse(timestampString);

    // Step 2: Calculate the time difference
    DateTime currentTime = DateTime.now();
    DateTime utcTime = currentTime.toUtc();
    Duration difference = utcTime.difference(timestamp);

    // Step 3: Format the time difference as "X minutes ago"
    String formattedTimeDifference = formatTimeDifference(difference);

    return formattedTimeDifference;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        curve: Curves.easeIn,
        duration: Duration(milliseconds: 300 + (index * 200)),
        transform: Matrix4.translationValues(isAnimate ? 0 : width, 0, 0),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 5,
              offset: const Offset(1, 2),
            ),
          ],
          color: AppColors.secondaryBackgroundColor,
          border: Border.all(color: Colors.red),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GapH(3),
            Row(
              children: [
                GoogleText(
                  text: logs.name ?? "",
                  textColor: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
                const GapW(5),
                if ((!(logs.connectionResponse?.mongodb ?? false) ||
                    !(logs.connectionResponse?.redis ?? false) ||
                    !(logs.server ?? false))) ...[
                  SizedBox(
                      height: 20,
                      child: Lottie.asset(AppImages.errorLoti, repeat: false)),
                ],
                const Spacer(),
                GoogleText(
                  text: timeDifference(logs.createdAt.toString()),
                  textColor: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                ),
              ],
            ),
            const GapH(5),
            Row(
              children: [
                Expanded(
                  child: DoubleTextWidget(
                      needGap: false,
                      text1: AppStrings.redis,
                      text2: logs.connectionResponse?.redis.toString() ?? "",
                      style2: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: logs.connectionResponse?.redis ?? false
                            ? Colors.blue
                            : Colors.red,
                      )),
                ),
                const GapW(20),
                Expanded(
                  child: DoubleTextWidget(
                      needGap: false,
                      text1: AppStrings.mongodb,
                      text2: logs.connectionResponse?.mongodb.toString() ?? "",
                      style2: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: logs.connectionResponse?.mongodb ?? false
                            ? Colors.blue
                            : Colors.red,
                      )),
                )
              ],
            ),
            DoubleTextWidget(
                needGap: false,
                text1: AppStrings.server,
                text2: logs.server.toString(),
                style2: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: logs.server ?? false ? Colors.blue : Colors.red,
                )),
          ],
        ),
      ),
    );
  }
}
