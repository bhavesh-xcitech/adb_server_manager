import 'dart:async';
import 'dart:io';

import 'package:adb_server_manager/app_globle.dart';
import 'package:adb_server_manager/common_widgets/app_bar.dart';
import 'package:adb_server_manager/common_widgets/app_button.dart';
import 'package:adb_server_manager/common_widgets/app_gap_height.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/common_widgets/custopm_top_snackbar.dart';
import 'package:adb_server_manager/features/backend_details/bloc/backends_control_options_bloc.dart';
import 'package:adb_server_manager/features/backend_details/widgets/alert_dialog_android.dart';
import 'package:adb_server_manager/features/server_list/bloc/backend_listing_bloc.dart';
import 'package:adb_server_manager/features/server_list/models/pm2_env_model.dart';
import 'package:adb_server_manager/features/server_list/widgets/double_text.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BackendDetails extends StatefulWidget {
  const BackendDetails({super.key, this.pM2ProcessInfo, required this.index});
  final PM2ProcessInfo? pM2ProcessInfo;
  final int index;

  @override
  State<BackendDetails> createState() => _BackendDetailsState();
}

class _BackendDetailsState extends State<BackendDetails> {
  final StreamController<String> _logStreamController =
      StreamController<String>();

  @override
  void initState() {
    AppGlobals().streamSocket.getResponse().listen((data) {});
    super.initState();
  }

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

  void showAlertDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Row(
          children: const [Icon(Icons.delete), Text(AppStrings.delete)],
        ),
        content: const Text(AppStrings.deleteConfigurationFromServerWarning),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              context.pop();
            },
            child: const Text(AppStrings.no),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () {
              context
                  .read<BackendsControlOptionsBloc>()
                  .add(OnClickOfDelete(name: pM2ProcessInfo?.name ?? ""));
            },
            child: const Text(AppStrings.yes),
          ),
        ],
      ),
    );
  }

  PM2ProcessInfo? pM2ProcessInfo;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BackendsControlOptionsBloc(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const CommonAppBar(text: AppStrings.backendDetails),
        body: StreamBuilder(
            stream: AppGlobals().streamSocket.getResponse(),
            builder: (context, AsyncSnapshot snapshot) {
              return BlocListener<BackendsControlOptionsBloc,
                  BackendsControlOptionsState>(
                listener: (context, state) {
                  if (state.startStatus.isSubmissionFailure) {
                    CustomSnackBar.show(
                        context: context,
                        message: state.errorMsg ?? AppStrings.apiErrorMsg);
                  }
                  if (state.startStatus.isSubmissionSuccess) {
                    context.read<BackendListingBloc>().add(InitiateListing());
                    CustomSnackBar.show(
                      context: context,
                      message: state.successMsg ?? '',
                    );
                  }
                  if (state.stopStatus.isSubmissionFailure) {
                    CustomSnackBar.show(
                        context: context,
                        message: state.errorMsg ?? AppStrings.apiErrorMsg);
                  }
                  if (state.stopStatus.isSubmissionSuccess) {
                    context.read<BackendListingBloc>().add(InitiateListing());
                    CustomSnackBar.show(
                      context: context,
                      message: state.successMsg ?? '',
                    );
                  }
                  if (state.restartStatus.isSubmissionFailure) {
                    CustomSnackBar.show(
                        context: context,
                        message: state.errorMsg ?? AppStrings.apiErrorMsg);
                  }
                  if (state.restartStatus.isSubmissionSuccess) {
                    context.read<BackendListingBloc>().add(InitiateListing());
                    CustomSnackBar.show(
                      context: context,
                      message: state.successMsg ?? '',
                    );
                  }
                  if (state.deleteStatus.isSubmissionFailure) {
                    CustomSnackBar.show(
                        context: context,
                        message: state.errorMsg ?? AppStrings.apiErrorMsg);
                  }
                  if (state.deleteStatus.isSubmissionSuccess) {
                    CustomSnackBar.show(
                      context: context,
                      message: state.successMsg ?? '',
                    );
                    context.read<BackendListingBloc>().add(InitiateListing());

                    context.pop();
                  }
                },
                child: BlocBuilder<BackendListingBloc, BackendListingState>(
                  builder: (listingContext, listingState) {
                  
                    return BlocBuilder<BackendsControlOptionsBloc,
                        BackendsControlOptionsState>(builder: (context, state) {
                      pM2ProcessInfo =
                          listingState.backendsDataList[widget.index];

                      return listingState.formStatus.isSubmissionInProgress
                          ? const Center(
                              child: CircularProgressIndicator.adaptive())
                          : listingState.formStatus.isSubmissionSuccess
                              ? Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      const GapH(5),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors
                                                        .secondaryColor)),
                                            child: IconButton(
                                                onPressed: () {
                                                  listingContext
                                                      .read<
                                                          BackendListingBloc>()
                                                      .add(InitiateListing());
                                                },
                                                icon: const Icon(
                                                  Icons.refresh,
                                                  color:
                                                      AppColors.secondaryColor,
                                                )),
                                          )),
                                      const GapH(10),
                                      DoubleTextWidget(
                                        text1: AppStrings.status,
                                        text2: pM2ProcessInfo?.pm2Env?.status ??
                                            "",
                                        style2: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15,
                                          color:
                                              pM2ProcessInfo?.pm2Env?.status ==
                                                      "online"
                                                  ? AppColors.decorationColor
                                                  : Colors.red,
                                        ),
                                      ),
                                      DoubleTextWidget(
                                        text1: AppStrings.name,
                                        text2: pM2ProcessInfo?.name ?? "",
                                      ),
                                      DoubleTextWidget(
                                        text1: AppStrings.pId,
                                        text2: pM2ProcessInfo?.pId.toString() ??
                                            "",
                                      ),
                                      DoubleTextWidget(
                                          text1: AppStrings.upTime,
                                          text2: changeTimeFormate(
                                              pM2ProcessInfo
                                                      ?.pm2Env?.pmUpTime ??
                                                  0)),
                                      DoubleTextWidget(
                                        text1: AppStrings.createdAt,
                                        text2: changeTimeFormate(
                                            pM2ProcessInfo?.pm2Env?.createdAt ??
                                                0),
                                      ),
                                      DoubleTextWidget(
                                        text1: AppStrings.nodeVersion,
                                        text2: pM2ProcessInfo
                                                ?.pm2Env?.nodeVersion ??
                                            "",
                                      ),
                                      DoubleTextWidget(
                                          text1: AppStrings.memory,
                                          text2: bytesToMB(pM2ProcessInfo
                                              ?.monitoring?.memory)),
                                      DoubleTextWidget(
                                          text1: AppStrings.cpu,
                                          text2: pM2ProcessInfo?.monitoring?.cpu
                                                  .toString() ??
                                              ""),
                                      const GapH(15),
                                      Row(
                                        children: [
                                          // if (!(pM2ProcessInfo?.pm2Env?.status ==
                                          //     "online")) ...[
                                          // const GapW(15),
                                          Flexible(
                                            child: AppCommonButton(
                                              isEnable: !(pM2ProcessInfo
                                                      ?.pm2Env?.status ==
                                                  "online"),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              isLoading: state.startStatus
                                                  .isSubmissionInProgress,
                                              text: AppStrings.start,
                                              onTap: () {
                                                context
                                                    .read<
                                                        BackendsControlOptionsBloc>()
                                                    .add(OnClickOfStart(
                                                        name: pM2ProcessInfo
                                                                ?.name ??
                                                            ""));
                                              },
                                            ),
                                          ),
                                          // ],
                                          // const GapW(15),
                                          Flexible(
                                            child: AppCommonButton(
                                              isEnable: (pM2ProcessInfo
                                                      ?.pm2Env?.status ==
                                                  "online"),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              isLoading: state.stopStatus
                                                  .isSubmissionInProgress,
                                              text: AppStrings.stop,
                                              onTap: () {
                                                context
                                                    .read<
                                                        BackendsControlOptionsBloc>()
                                                    .add(OnClickOfStop(
                                                        name: pM2ProcessInfo
                                                                ?.name ??
                                                            ""));
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      const GapH(8),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors
                                                      .secondaryColor)),
                                          child: snapshot.connectionState ==
                                                  ConnectionState.waiting
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator
                                                          .adaptive(),
                                                )
                                              : snapshot.hasError
                                                  ? Text(
                                                      "Error: ${snapshot.error}")
                                                  : snapshot.data == null
                                                      ? const SingleChildScrollView(
                                                          child: Text(
                                                              "No data available"),
                                                        )
                                                      : Container(
                                                          child: Text(
                                                            snapshot.data
                                                                .toString(),
                                                            style:
                                                                const TextStyle(
                                                              color: AppColors
                                                                  .decorationColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Center(
                                  child: GoogleText(
                                    text: listingState.msg ??
                                        AppStrings.apiErrorMsg,
                                    textColor: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                );
                    });
                  },
                ),
              );
            }),
        bottomNavigationBar: SafeArea(
          child: BlocBuilder<BackendListingBloc, BackendListingState>(
            builder: (listingContext, listingState) {
              return BlocBuilder<BackendsControlOptionsBloc,
                  BackendsControlOptionsState>(
                builder: (context, state) {
                  if (listingState.formStatus.isSubmissionSuccess) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppCommonButton(
                              isLoading:
                                  state.restartStatus.isSubmissionInProgress,
                              text: AppStrings.restart,
                              onTap: () {
                                context.read<BackendsControlOptionsBloc>().add(
                                    OnClickOfRestart(
                                        name: pM2ProcessInfo?.name ?? ""));
                              },
                            ),
                            const GapH(15),
                            AppCommonButton(
                              color: Colors.red,
                              isLoading:
                                  state.deleteStatus.isSubmissionInProgress,
                              text: AppStrings.delete,
                              onTap: () {
                                if (Platform.isIOS) {
                                  showAlertDialog(context);
                                } else {
                                  androidDialog(
                                      context: context,
                                      name: pM2ProcessInfo?.name ?? "");
                                }
                              },
                            ),
                          ],
                        ));
                  } else {
                    return Container(
                      height: 1,
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
