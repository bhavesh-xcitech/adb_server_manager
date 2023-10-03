import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    this.text,
    this.onBackButton,
    this.isNeedBackBtn = true,
  });

  final String? text;
  final Function? onBackButton;
  final bool isNeedBackBtn;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text(text ?? '',
            textAlign: TextAlign.center,
            style:
                GoogleFonts.nunito(fontSize: 19, fontWeight: FontWeight.w800)),
        elevation: 0,
        backgroundColor: AppColors.secondaryBackgroundColor,
        leading: isNeedBackBtn
            ? GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => onBackButton?.call() ?? context.pop(),
                child: const Icon(Icons.arrow_back_ios_new))
            : null);
  }
}
