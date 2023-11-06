import 'package:adb_server_manager/common_widgets/app_gap_height.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/features/dashboard/bloc/dash_board_bloc.dart';
import 'package:adb_server_manager/features/dashboard/widgets/detail_box.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

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
  DashBoardBloc dashBoardBloc = DashBoardBloc();

  @override
  void initState() {
    dashBoardBloc.add(GetDashBoardData());
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
    super.initState();
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => dashBoardBloc,
      child: BlocListener<DashBoardBloc, DashBoardState>(
        listener: (context, state) {
          if (state.formStatus.isSubmissionSuccess) {
            startAnimation();
          }
        },
        child: BlocBuilder<DashBoardBloc, DashBoardState>(
          builder: (context, state) {
            if (state.formStatus.isSubmissionInProgress) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state.formStatus.isSubmissionSuccess &&
                state.dashboardList.isEmpty) {
              return const Center(
                child: GoogleText(
                  text: AppStrings.noStatusAvailable,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              );
            } else if (state.formStatus.isSubmissionSuccess &&
                state.dashboardList.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
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
                          child: GoogleText(
                            text: state.dashboardList[index].name ?? "",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const GapH(5),
                        Row(
                          children: [
                            DetailBox(
                              title: AppStrings.mongodb,
                              data: state.dashboardList[index]
                                      .connectionResponse?.mongodb ??
                                  false,
                              height: _height,
                              color: _color,
                            ),
                            DetailBox(
                              title: AppStrings.redis,
                              data: state.dashboardList[index]
                                      .connectionResponse?.redis ??
                                  false,
                              height: _height,
                              color: _color,
                            ),
                            DetailBox(
                              title: AppStrings.server,
                              data: state.dashboardList[index].server ?? false,
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
            } else {
              return Center(
                child: GoogleText(
                  text: state.msg ?? AppStrings.apiErrorMsg,
                  textColor: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              );
            }
          },
        ),
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
