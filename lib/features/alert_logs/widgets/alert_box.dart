import 'package:adb_server_manager/common_widgets/app_gap_height.dart';
import 'package:adb_server_manager/common_widgets/app_gap_width.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/features/alert_logs/models/server_logs_model.dart';
import 'package:adb_server_manager/features/server_list/widgets/double_text.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  String convertDateTime(int? seconds) {
    int secondsSinceEpoch =
        seconds ?? 0; // Replace this with your seconds value
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000);
    String formattedDate = DateFormat("dd-MM-yyyy HH:mm:ss").format(dateTime);

    return formattedDate;
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
          border: Border.all(color: Colors.red, width: 2.5),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GapH(3),
            Align(
              alignment: Alignment.topRight,
              child: GoogleText(
                text: convertDateTime(logs.createdAt?.seconds).toString() ?? "",
                textColor: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              children: [
                GoogleText(
                  text: logs.name ?? "",
                  textColor: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
                const GapW(5),
                SizedBox(height: 20, child: Lottie.asset('assets/error.json')),
              ],
            ),
            DoubleTextWidget(
              text1: AppStrings.name,
              text2: logs.name ?? "",
            ),
            DoubleTextWidget(
                text1: AppStrings.redis,
                text2: logs.connectionResponse?.redis.toString() ?? "",
                style2: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: logs.connectionResponse?.redis ?? false
                      ? Colors.blue
                      : Colors.red,
                )),
            DoubleTextWidget(
                text1: AppStrings.mongodb,
                text2: logs.connectionResponse?.mongodb.toString() ?? "",
                style2: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: logs.connectionResponse?.mongodb ?? false
                      ? Colors.blue
                      : Colors.red,
                ))
          ],
        ),
      ),
    );
  }
}
