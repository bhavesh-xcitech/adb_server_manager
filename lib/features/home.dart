import 'package:adb_server_manager/common_widgets/app_bar.dart';
import 'package:adb_server_manager/common_widgets/bottom_nav_button.dart';
import 'package:adb_server_manager/features/backend_details/all_logs_screen.dart';
import 'package:adb_server_manager/features/logs/bloc/logs_bloc.dart';
import 'package:adb_server_manager/features/server_list/backends_list_screen.dart';
import 'package:adb_server_manager/features/server_logs/server_logs_screen.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  int selectedIndex = 0;

  List listOfScreen = [
    const BackendsListingScreen(),
    const ServersLogsScreen(),
    const AllLogsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar:
          const CommonAppBar(text: AppStrings.adbMonitor, isNeedBackBtn: false),
      body: listOfScreen[selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25) +
              const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: BottomNavButton(
                  onTap: () {
                    context.read<LogsBloc>().add(ClearAllLogs());

                    selectedIndex = 0;
                    setState(() {});
                  },
                  iconData: Icons.list,
                  text: "Listing",
                  index: 0,
                  selectedIndex: selectedIndex,
                ),
              ),
              Expanded(
                child: BottomNavButton(
                  onTap: () {
                    context.read<LogsBloc>().add(ClearAllLogs());
                    selectedIndex = 1;
                    setState(() {});
                  },
                  iconData: Icons.ballot_outlined,
                  text: "Status Logs",
                  index: 1,
                  selectedIndex: selectedIndex,
                ),
              ),
              Expanded(
                child: BottomNavButton(
                  onTap: () {
                    selectedIndex = 2;
                    setState(() {});
                  },
                  iconData: Icons.cloud_download_outlined,
                  text: "Server Logs",
                  index: 2,
                  selectedIndex: selectedIndex,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
