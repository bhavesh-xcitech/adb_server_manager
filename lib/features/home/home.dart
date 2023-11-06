// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adb_server_manager/common_widgets/app_bar.dart';
import 'package:adb_server_manager/common_widgets/app_button.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/common_widgets/custopm_top_snackbar.dart';
import 'package:adb_server_manager/features/alert_logs/alert_screen.dart';
import 'package:adb_server_manager/features/alert_logs/bloc/alerts_logs_bloc.dart';
import 'package:adb_server_manager/features/backend_details/all_logs_screen.dart';
import 'package:adb_server_manager/features/dashboard/dashboard_screen.dart';
import 'package:adb_server_manager/features/firebase_notifications_service.dart';
import 'package:adb_server_manager/features/home/bloc/home_bloc.dart';
import 'package:adb_server_manager/features/home/widgets/custom_drawer.dart';
import 'package:adb_server_manager/features/home/widgets/dialogs.dart';
import 'package:adb_server_manager/features/login/bloc/login_bloc.dart';
import 'package:adb_server_manager/features/server_list/backends_list_screen.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:adb_server_manager/resource/shared_pref.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:package_info_plus/package_info_plus.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  // int selectedIndex;

  const HomeScreen({
    Key? key,
    // this.selectedIndex = 0,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PushNotificationService pushNotificationService = PushNotificationService();
  // HomeBloc homeBloc = HomeBloc();
  late bool notificationEnable;
  PackageInfo? packageInfo;

  @override
  void initState() {
    pushNotificationService.requestNotificationPermission();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      asyncInit().then((value) {
        pushNotificationService.firebaseInit(
          context,
        );
        pushNotificationService.setupInteractMessage(context);
      });
    });
    super.initState();
  }

  Future<void> asyncInit() async {
    notificationEnable = await SharedPref.getEnableNotification();
    packageInfo = await PackageInfo.fromPlatform();
    print("notificationinitttttttt enable $notificationEnable");

    setState(() {});
  }

  List listOfScreen = [
    const DashBoardScreen(),
    const AlertScreen(),
    const BackendsListingScreen(),
    const AllLogsScreen()
  ];
  List iconList = [
    Icons.dashboard,
    Icons.warning,
    Icons.list,
    Icons.cloud_download_outlined,
  ];
  List name = [
    "DashBoard",
    "Alerts",
    "listing",
    "All-Logs",
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state.addUserFormzStatus.isSubmissionFailure) {
              DiffDialogs.notificationToggleFail(context);
            }
            if (state.addUserFormzStatus.isSubmissionSuccess) {
              DiffDialogs.notificationOffDialog(context);

              await SharedPref.setEnableNotification(notificationEnable);
            }
          },
        ),
        BlocListener<AlertsLogsBloc, AlertsLogsState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state.deleteLogsStatus.isSubmissionSuccess) {
              context.read<AlertsLogsBloc>().add(GetServerLogs());
            }
          },
        ),
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (homeContext, homeState) {
          return BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return BlocBuilder<AlertsLogsBloc, AlertsLogsState>(
                builder: (alertsLogsContext, alertsLogsState) {
                  return Scaffold(
                    drawer: (packageInfo != null)
                        ? CustomDrawer(
                            addUserFormzStatus: state.addUserFormzStatus,
                            onChange: (value) {
                              notificationEnable = !notificationEnable;
                              setState(() {});
                              context.read<LoginBloc>().add(AddUserInfo(
                                  isNotificationEnable: notificationEnable));
                            },
                            packageInfo: packageInfo!,
                            isNotificationEnabled: notificationEnable,
                            phoneNumber: FirebaseAuth
                                    .instance.currentUser?.phoneNumber ??
                                "",
                          )
                        : const SizedBox(),
                    backgroundColor: AppColors.backgroundColor,
                    appBar: CommonAppBar(
                      deleteStatus: alertsLogsState.deleteLogsStatus,
                      onTapOfDelete: homeState.selectedIndex == 1
                          ? () {
                              if (alertsLogsState.allServerLogs.isNotEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      elevation: 5,
                                      backgroundColor:
                                          AppColors.backgroundColor,
                                      title: Row(
                                        children: const [
                                          GoogleText(
                                              text: 'You Want To Delete'),
                                          Spacer()
                                        ],
                                      ),
                                      content: const GoogleText(
                                          text:
                                              "you are permanent deleting from the database "),
                                      actions: <Widget>[
                                        AppCommonButton(
                                            onTap: () {
                                              alertsLogsContext
                                                  .read<AlertsLogsBloc>()
                                                  .add(DeleteServerLogs());
                                              Navigator.of(context).pop();
                                            },
                                            text: "ok")
                                      ],
                                    );
                                  },
                                );
                              } else {
                                CustomSnackBar.show(
                                    context: context,
                                    message: "There is no items for Delete");
                              }
                            }
                          : null,
                      text: AppStrings.adbMonitor,
                      isNeedBackBtn: false,
                      leadingIcon: Icons.settings,
                    ),
                    body: listOfScreen[homeState.selectedIndex],
                    bottomNavigationBar: AnimatedBottomNavigationBar.builder(
                      itemCount: iconList.length,
                      notchMargin: 0,
                      tabBuilder: (int index, bool isActive) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              iconList[index],
                              size: isActive ? 25 : 20,
                              color: isActive ? Colors.blue : Colors.white,
                            ),
                            GoogleText(
                              text: name[index],
                              fontSize: 12,
                            )
                          ],
                        );
                      },
                      backgroundColor: AppColors.backgroundColor,
                      activeIndex: homeState.selectedIndex,
                      gapLocation: GapLocation.none,
                      // gapLocation: GapLocation.center,
                      notchSmoothness: NotchSmoothness.defaultEdge,
                      leftCornerRadius: 32,
                      rightCornerRadius: 32, // Adjust as needed

                      onTap: (index) {
                        if (homeState.selectedIndex != 1) {
                          alertsLogsContext
                              .read<AlertsLogsBloc>()
                              .add(ResetPage());
                        }
                        homeContext
                            .read<HomeBloc>()
                            .add(UpdateSelectedIndex(index: index));
                      },
                      //other params
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
