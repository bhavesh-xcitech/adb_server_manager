import 'package:adb_server_manager/common_widgets/app_button.dart';
import 'package:adb_server_manager/common_widgets/app_gap_height.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/common_widgets/app_textfild.dart';
import 'package:adb_server_manager/common_widgets/custopm_top_snackbar.dart';
import 'package:adb_server_manager/features/login/bloc/log_in_cubit.dart';
import 'package:adb_server_manager/features/login/bloc/login_bloc.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/app_images.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:adb_server_manager/resource/shared_pref.dart';
import 'package:adb_server_manager/routers/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isError = false;
  late AnimationController _controller;
  late Animation<Offset> imageAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    imageAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from the bottom of the screen
      end: const Offset(0, 0), // End at the top of the screen
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOutCubicEmphasized),
      ),
    );
    startAnimation();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void startAnimation() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        _controller.forward();
        _controller.addListener(() {
          setState(() {});
        });
        // setState(() {

        // });
      }
    });
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
      context.read<LoginBloc>().add(const GetAuthenticatedUsers());
    } else {
      CustomSnackBar.show(context: context, message: "Add phone number");
    }
  }

  Future<void> setToLocaleStorage() async {
    await SharedPref.setLoggedIn(true);
    await SharedPref.setEnableNotification(true);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OtpVerificationCubit(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImages.background), fit: BoxFit.cover)),
          child: BlocBuilder<LoginBloc, LoginState>(
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
                        context.read<LoginBloc>().add(AddUserInfo(
                              phone: "+91${state.phone}",
                            ));
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
                  BlocListener<LoginBloc, LoginState>(
                    listener: (context, state) async {
                      if (state.addUserFormzStatus.isSubmissionSuccess) {
                        setToLocaleStorage().then((value) {
                          CustomSnackBar.show(
                              context: context, message: state.msg.toString());
                          context.go(AppRouteNames.home);
                        });
                      } else if (state.addUserFormzStatus.isSubmissionFailure) {
                        if (state.msg != null &&
                            state.msg!.contains("Restart your App")) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                backgroundColor: AppColors.backgroundColor,
                                title: GoogleText(
                                  text: "Restart Required",
                                  textColor: AppColors.secondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                content: GoogleText(
                                    text:
                                        "we recommend restarting the app ,This will help enhance your experience and ensure optimal performance."),
                              );
                            },
                          );
                        } else {
                          CustomSnackBar.show(
                              context: context,
                              message: state.msg ?? AppStrings.apiErrorMsg);
                        }
                      }

                      if (state.loadUsersFormStatus.isSubmissionSuccess) {
                        bool isContain = state.validPhoneNumbers
                            .contains(phoneNumController.text);

                        if (isContain) {
                          await context
                              .read<OtpVerificationCubit>()
                              .getOtp(phoneNumController.text);
                        } else {
                          CustomSnackBar.show(
                              context: context,
                              message: "This number is not allow to login");
                        }
                      } else if (state
                          .loadUsersFormStatus.isSubmissionFailure) {
                        CustomSnackBar.show(
                            context: context, message: AppStrings.apiErrorMsg);
                      }
                    },
                  ),
                ],
                child: BlocBuilder<OtpVerificationCubit, LoginState>(
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SlideTransition(
                          position: imageAnimation,
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(AppImages.logo))),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: AppColors.secondaryBackgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
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
                                    textInputFormatter: [
                                      FilteringTextInputFormatter
                                          .digitsOnly, // Allow only digits (0-9)
                                      LengthLimitingTextInputFormatter(
                                          10), // Limit the length to 5 characters
                                    ],
                                    textInputType: TextInputType.number,
                                    validator: (String? value) {
                                      if (value == null || value.trim() == '') {
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
                                          blocState.addUserFormzStatus
                                              .isSubmissionInProgress ||
                                          blocState.loadUsersFormStatus
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
