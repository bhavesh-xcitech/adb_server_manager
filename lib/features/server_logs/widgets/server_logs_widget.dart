// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adb_server_manager/common_widgets/app_gap_height.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/features/server_list/widgets/double_text.dart';
import 'package:adb_server_manager/features/server_logs/bloc/server_logs_bloc.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ServerLogsCard extends StatelessWidget {
  final int index;
  const ServerLogsCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  String convertDateTime(int? seconds) {
    int secondsSinceEpoch =
        seconds ?? 0; // Replace this with your seconds value
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000);
    String formattedDate = DateFormat("dd-MM-yyyy HH:mm:a").format(dateTime);
    print(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServerLogsBloc, ServerLogsState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.secondaryBackgroundColor,
            border: Border.all(
              color: state.allServerLogs[index].status == "online"
                  ? AppColors.decorationColor
                  : Colors.red,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const GapH(3),
              GoogleText(
                textAlign: TextAlign.end,
                text: state.allServerLogs[index].status ?? "",
                textColor: state.allServerLogs[index].status == "online"
                    ? AppColors.decorationColor
                    : Colors.red,
              ),
              DoubleTextWidget(
                text1: AppStrings.name,
                text2: state.allServerLogs[index].name ?? "",
              ),
              // DoubleTextWidget(
              //   text1: AppStrings.mongodb,
              //   text2: state.allServerLogs[index].connectionResponse?.mongodb
              //           .toString() ??
              //       "",
              // ),
              //  DoubleTextWidget(
              //   text1: AppStrings.redis,
              //   text2: state.allServerLogs[index].connectionResponse?.redis
              //           .toString() ??
              //       "",
              // ),
              DoubleTextWidget(
                  text1: AppStrings.time,
                  text2: state.allServerLogs[index].createdAt.toString()),
            ],
          ),
        );
      },
    );
  }
}
