import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBorderTextFormField extends StatelessWidget {
  const AppBorderTextFormField({
    super.key,
    this.controller,
    this.onChanged,
    this.validator,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.readOnly = false,
    this.onTap,
    this.focusNode,
    this.onEditingComplete,
    this.textInputType,
    this.textInputFormatter,
    this.textInputAction,
  });

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function? onTap;
  final String? Function(String?)? validator;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final bool readOnly;
  final FocusNode? focusNode;
  final Function? onEditingComplete;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      textInputAction: textInputAction,
      inputFormatters: textInputFormatter,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onEditingComplete: () =>
          onEditingComplete?.call() ?? TextInput.finishAutofillContext(),

      focusNode: focusNode,
      onTap: () => onTap?.call(),
      // enabled: enabled,
      controller: controller,
      readOnly: readOnly,
      onChanged: onChanged,
      validator: validator,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        errorText: errorText,
        errorStyle: GoogleFonts.nunito(
          fontSize: 12,
          color: Colors.red,
          fontWeight: FontWeight.w400,
        ),
        isDense: true,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.fillColor,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.secondaryColor,
            width: 0.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 0.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.secondaryColor,
            width: 0.5,
          ),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.nunito(
            fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
        // fillColor: AppColors.backgroundColor,
        filled: true,
      ),
    );
  }
}
