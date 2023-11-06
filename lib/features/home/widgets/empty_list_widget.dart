import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/resource/app_images.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image.asset(AppImages.emptyList,color: ,),
        Stack(
          children: [
            SvgPicture.asset(AppImages.emptyList),
            const Positioned(
                bottom: 10,
                right: 0,
                left: 0,
                child: GoogleText(
                  text: AppStrings.emptyListText,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ))
          ],
        ),
      ],
    );
  }
}
