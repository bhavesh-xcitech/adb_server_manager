import 'package:adb_server_manager/common_widgets/app_gap_height.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/features/dashboard/widgets/detail_box.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with SingleTickerProviderStateMixin {
  double _width = 10;
  double _height = 55;
  Color _color = AppColors.primaryColor;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(0);
  late AnimationController _controller;
  late Animation<Offset> messageAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    messageAnimation = Tween<Offset>(
      begin: const Offset(20.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(
          0.5,
          1.0,
          curve: Curves.ease,
        ),
      ),
    );

    startAnimation();
  }

  void startAnimation() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        _controller.forward();
        _controller.addListener(() {
          setState(() {
            _height = 100;
            _width = 50;
            _color = AppColors.secondaryBackgroundColor;
            _borderRadius = BorderRadius.circular(15);
          });
        });
        // setState(() {

        // });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return const GapH(20);
        },
        itemCount: 2,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlideTransition(
                position: messageAnimation,
                child: const GoogleText(
                  text: "server name",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const GapH(10),
              Row(
                children: [
                  DetailBox(
                    title: AppStrings.mongodb,
                    data: "2.2.2",
                    height: _height,
                    color: _color,
                  ),
                  DetailBox(
                    title: AppStrings.redis,
                    data: "2.2.2",
                    height: _height,
                    color: _color,
                  ),
                  DetailBox(
                    title: "server",
                    data: "2.2.2",
                    height: _height,
                    color: _color,
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // Dispose the animation controller and remove the listener.
    _controller.dispose();
    super.dispose();
  }
}
