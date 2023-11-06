import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/features/alert_logs/bloc/alerts_logs_bloc.dart';
import 'package:adb_server_manager/features/alert_logs/widgets/alert_box.dart';
import 'package:adb_server_manager/features/home/widgets/empty_list_widget.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  final ScrollController scrollController = ScrollController();
  bool offAnimation = false;

  @override
  void initState() {
    context.read<AlertsLogsBloc>().add(GetServerLogs());
    scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      context.read<AlertsLogsBloc>().add(GetMoreServerLogs());
    }
  }

  Future<void> startAnimation() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        offAnimation = true;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AlertsLogsBloc, AlertsLogsState>(
      listener: (context, state) {
        if (state.initialStatus.isSubmissionSuccess) {
          startAnimation();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: BlocBuilder<AlertsLogsBloc, AlertsLogsState>(
          builder: (context, state) {
            return state.initialStatus.isSubmissionInProgress ||
                    state.deleteLogsStatus.isSubmissionInProgress
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : state.initialStatus.isSubmissionSuccess
                    ? state.allServerLogs.isNotEmpty
                        ? SafeArea(
                            child: ListView.builder(
                              itemCount: state.allServerLogs.length + 1,
                              controller: scrollController,
                              itemBuilder: (context, index) {
                                if (index < state.allServerLogs.length) {
                                  return AlertBoxWidget(
                                    isAnimate: offAnimation,
                                    index: index,
                                    logs: state.allServerLogs[index],
                                  );
                                } else {
                                  if (state.listLoadingStatus
                                      .isSubmissionInProgress) {
                                    return const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Center(
                                          child: CircularProgressIndicator
                                              .adaptive()),
                                    );
                                  } else {
                                    return null;
                                  }
                                }
                              },
                            ),
                          )
                        : const Center(child: EmptyListWidget())
                    : Center(
                        child: GoogleText(
                          text: state.msg ?? AppStrings.apiErrorMsg,
                          textColor: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      );
          },
        ),
      ),
    );
  }
}
