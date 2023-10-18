import 'package:adb_server_manager/common_widgets/app_bar.dart';
import 'package:adb_server_manager/common_widgets/bottom_nav_button.dart';
import 'package:adb_server_manager/features/server_list/backends_list_screen.dart';
import 'package:adb_server_manager/features/server_logs/server_logs_screen.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List listOfScreen = [];

  @override
  void initState() {
    listOfScreen = [
      const BackendsListingScreen(),
      const ServersLogsScreen(),
    ];

    // print(scrollController.position.pixels);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar:
          const CommonAppBar(text: AppStrings.adbMonitor, isNeedBackBtn: false),
      body: listOfScreen[selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomNavButton(
                onTap: () {
                  selectedIndex = 0;
                  setState(() {});
                },
                iconData: Icons.list,
                text: "Listing",
                index: 0,
                selectedIndex: selectedIndex,
              ),
              BottomNavButton(
                onTap: () {
                  selectedIndex = 1;
                  setState(() {});
                },
                iconData: Icons.ballot,
                text: "Server Logs",
                index: 1,
                selectedIndex: selectedIndex,
              )

              // IconButton(
              //     onPressed: () {
              //       selectedIndex = 0;
              //       setState(() {});
              //     },
              //     icon: const Icon(Icons.line_weight_outlined)),
              // IconButton(
              //     onPressed: () {
              //       selectedIndex = 1;
              //       setState(() {});
              //     },
              //     icon: const Icon(Icons.line_weight_outlined,color: Colors.white,))
            ],
          ),
        ),
      ),
    );
  }
}
