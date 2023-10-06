import 'package:adb_server_manager/common_widgets/app_gap_width.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/features/backend_details/bloc/backends_control_options_bloc.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void androidDialog({context, required String name}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      backgroundColor: AppColors.backgroundColor,
      title: Row(
        children: const [
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          GapW(5),
          GoogleText(text: AppStrings.delete)
        ],
      ),
      content: const GoogleText(
          text: AppStrings.deleteConfigurationFromServerWarning),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            ctx.pop();
          },
          child: const Text(AppStrings.no),
        ),
        TextButton(
          onPressed: () {
            context
                .read<BackendsControlOptionsBloc>()
                .add(OnClickOfDelete(name: name));
          },
          child: const Text(AppStrings.yes),
        ),
      ],
    ),
  );
}
