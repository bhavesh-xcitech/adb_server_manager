import 'package:adb_server_manager/common_widgets/app_bar.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/features/alert_logs/alert_screen.dart';
import 'package:adb_server_manager/features/backend_details/all_logs_screen.dart';
import 'package:adb_server_manager/features/dashboard/dashboard_screen.dart';
import 'package:adb_server_manager/features/server_list/backends_list_screen.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  int selectedIndex = 1;

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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar:
          const CommonAppBar(text: AppStrings.adbMonitor, isNeedBackBtn: false),
      body: listOfScreen[selectedIndex],

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
              GoogleText(text: name[index] ,fontSize: 12,)
            ],
          );
        },
        backgroundColor: AppColors.backgroundColor,
        activeIndex: selectedIndex,
        gapLocation: GapLocation.none,
        // gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
  leftCornerRadius: 32,
  rightCornerRadius: 32, // Adjust as needed
   
        onTap: (index) => setState(() => selectedIndex = index),
        //other params
      ),
    );
  }
}
