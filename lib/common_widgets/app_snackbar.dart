import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:flutter/material.dart';

showMySnackBar({
  required BuildContext context,
  required String message,
  final int? durationTime,
  final SnackBarBehavior? behavior,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: behavior,
      backgroundColor: AppColors.secondaryBackgroundColor,
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: durationTime ?? 3)));
}
