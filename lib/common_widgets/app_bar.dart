import 'package:adb_server_manager/common_widgets/app_button.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar(
      {super.key,
      this.text,
      this.onTapOfLeading,
      this.deleteStatus = FormzStatus.pure,
      this.isNeedBackBtn = true,
      this.context,
      this.onTapOfDelete,
      this.leadingIcon});

  final String? text;
  final Function? onTapOfLeading;
  final Function? onTapOfDelete;
  final bool isNeedBackBtn;
  final IconData? leadingIcon;
  final BuildContext? context;
  final FormzStatus deleteStatus;

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
                onTap: () => onTapOfLeading?.call() ?? context.pop(),
                child: Icon(leadingIcon ?? Icons.arrow_back_ios_new))
            : null,
        actions: (onTapOfDelete != null)
            ? [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: AppCommonButton(
                    isLoading: deleteStatus.isSubmissionInProgress,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    fontSize: 12,
                    margin: const EdgeInsets.all(5),
                    // width: 100,
                    onTap: () => onTapOfDelete?.call(),
                    text: "DELETE",
                    color: Colors.red,
                  ),
                )
              ]
            : null);
  }
}
