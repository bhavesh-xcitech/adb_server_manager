import 'package:adb_server_manager/common_widgets/app_button.dart';
import 'package:adb_server_manager/common_widgets/app_gap_height.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/common_widgets/app_textfild.dart';
import 'package:adb_server_manager/common_widgets/custopm_top_snackbar.dart';
import 'package:adb_server_manager/features/login/bloc/log_in_cubit.dart';
import 'package:adb_server_manager/features/login/bloc/login_bloc.dart';
import 'package:adb_server_manager/features/notifications/bloc/notifications_bloc.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/app_images.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:adb_server_manager/routers/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginBloc loginBloc = LoginBloc();
  @override
  void initState() {
    loginBloc.add(const GetAuthenticatedUsers());
    super.initState();
  }

  afterGetOtp(
      {required LoginState state, required BuildContext context}) async {
    if (otpController.text.isNotEmpty) {
      await context.read<OtpVerificationCubit>().loginWithPhone(
          code: otpController.text, verificationId: state.verificationId ?? "");
    } else {
      CustomSnackBar.show(context: context, message: "Add OtpCode");
    }
  }

  afterFillPhoneNum(
      {required LoginState blocState, required BuildContext context}) async {
    if (phoneNumController.text.isNotEmpty) {
      bool isContain =
          blocState.validPhoneNumbers.contains(phoneNumController.text);
      if (isContain) {
        await context
            .read<OtpVerificationCubit>()
            .getOtp(phoneNumController.text);
      } else {
        CustomSnackBar.show(
            context: context, message: "This number is not allow to login");
      }
    } else {
      CustomSnackBar.show(context: context, message: "Add phone number");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => loginBloc,
        ),
        BlocProvider(
          create: (context) => OtpVerificationCubit(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, blocState) {
            return MultiBlocListener(
              listeners: [
                BlocListener<OtpVerificationCubit, LoginState>(
                  listener: (context, state) {
                    if (state.getOtpFormzStatus.isSubmissionSuccess) {
                      CustomSnackBar.show(
                          context: context,
                          message: state.msg ?? "Otp sent successfully");
                    }
                    if (state.loginFormzStatus.isSubmissionSuccess) {
                      context.read<NotificationsBloc>().add(
                          AddToFireStore(phone: state.phone, uid: state.uid));
                    }
                    if (state.getOtpFormzStatus.isSubmissionFailure) {
                      CustomSnackBar.show(
                          context: context,
                          message: state.msg ?? AppStrings.apiErrorMsg);
                    }
                    if (state.loginFormzStatus.isSubmissionFailure) {
                      CustomSnackBar.show(
                          context: context,
                          message: state.msg ?? AppStrings.apiErrorMsg);
                    }
                  },
                ),
                BlocListener<NotificationsBloc, NotificationsState>(
                  listener: (context, state) {
                    if (state.firebaseFormzStatus.isSubmissionSuccess) {
                      context.pushReplacement(AppRouteNames.home);
                    }
                  },
                ),
              ],
              child: BlocBuilder<NotificationsBloc, NotificationsState>(
                builder: (context, notificationsState) {
                  return BlocBuilder<OtpVerificationCubit, LoginState>(
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AppImages.logo))),
                          ),
                          Center(
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: AppColors.secondaryBackgroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 25, horizontal: 20),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const GoogleText(
                                      text: AppStrings.hello,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    const GoogleText(
                                      text: AppStrings.welcomeBack,
                                      fontSize: 15,
                                    ),
                                    const GapH(10),
                                    AppBorderTextFormField(
                                      textInputType: TextInputType.number,
                                      validator: (String? value) {
                                        if (value == null ||
                                            value.trim() == '') {
                                          return AppStrings.phoneIsRequired;
                                        }

                                        return null;
                                      },
                                      controller: phoneNumController,
                                      hintText: AppStrings.phoneNum,
                                    ),
                                    const GapH(10),
                                    if (state.isOtpSent) ...[
                                      const SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Pinput(
                                          defaultPinTheme: PinTheme(
                                            width: 56,
                                            height: 56,
                                            textStyle: GoogleFonts.oxygen(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.fillColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          length: 6,
                                          controller: otpController,
                                        ),
                                      ),
                                    ],
                                    const GapH(20),
                                    AppCommonButton(
                                        isLoading: state.getOtpFormzStatus
                                                .isSubmissionInProgress ||
                                            state.loginFormzStatus
                                                .isSubmissionInProgress ||
                                            notificationsState
                                                .firebaseFormzStatus
                                                .isSubmissionInProgress,
                                        onTap: () => state.getOtpFormzStatus
                                                .isSubmissionSuccess
                                            ? afterGetOtp(
                                                state: state, context: context)
                                            : afterFillPhoneNum(
                                                blocState: blocState,
                                                context: context),
                                        text: state.isOtpSent
                                            ? AppStrings.logIn
                                            : AppStrings.getOtp),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
