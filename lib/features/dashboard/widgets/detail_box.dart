import 'package:adb_server_manager/common_widgets/app_gap_height.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:flutter/material.dart';

class DetailBox extends StatelessWidget {
  final String title;
  final String data;
  final double height;

  final Color color;

  const DetailBox({
    super.key,
    required this.title,
    required this.data,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedContainer(
        height: height,
        duration: const Duration(milliseconds: 400),
        curve: Curves.bounceInOut,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.btnColor),
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FittedBox(child: GoogleText(text: title)),
              const GapH(5),
              FittedBox(child: GoogleText(text: data)),
            ],
          ),
        ),
      ),
    );
  }
}
