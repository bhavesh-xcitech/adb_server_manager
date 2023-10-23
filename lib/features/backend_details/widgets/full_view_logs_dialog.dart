import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/features/logs/bloc/logs_bloc.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showFullLogsView({required BuildContext ctx}) {
  showDialog(
    context: ctx,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (BuildContext context, state) {
        return BlocBuilder<LogsBloc, LogsState>(
          // here use logsstate cause in bottom we use list from this state , if
          // here just write stae it not work cause it take stae of upper widget
          builder: (context, logsState) {
            return Dialog(
              insetPadding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.btnColor),
                    color: AppColors.backgroundColor),
                constraints:
                    const BoxConstraints.expand(), // Take the whole screen
                child: Column(
                  children: [
                    Row(
                      children: [
                        const GoogleText(text: "RealTime Logs"),
                        Expanded(
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the popup
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: ListView.builder(
                      // reverse: true,
                      itemCount: logsState.logDataList.length,
                      itemBuilder: (context, index) {
                        final reversedIndex =
                            logsState.logDataList.length - 1 - index;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            logsState.logDataList[reversedIndex],
                            style: const TextStyle(
                              color: AppColors.decorationColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      },
                    )),
                  ],
                ),
              ),
            );
          },
        );
      });
    },
  );
}
