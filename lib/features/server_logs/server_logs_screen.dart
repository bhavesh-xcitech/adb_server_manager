import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/features/server_logs/bloc/server_logs_bloc.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'widgets/server_logs_widget.dart';

class ServersLogsScreen extends StatefulWidget {
  // ScrollController scrollController;
  const ServersLogsScreen({
    super.key,
  });

  @override
  State<ServersLogsScreen> createState() => _ServersLogsScreenState();
}

class _ServersLogsScreenState extends State<ServersLogsScreen> {
  ServerLogsBloc serverLogsBloc = ServerLogsBloc();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    serverLogsBloc.add(GetServerLogs());

    scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      serverLogsBloc.add(GetMoreServerLogs());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3),
      child: BlocProvider(
        create: (context) => serverLogsBloc,
        child: BlocBuilder<ServerLogsBloc, ServerLogsState>(
          builder: (context, state) {
            return state.initialStatus.isSubmissionInProgress
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : state.initialStatus.isSubmissionSuccess
                    ? SafeArea(
                        child: ListView.builder(
                          itemCount: state.allServerLogs.length + 1,
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            if (index < state.allServerLogs.length) {
                              return ServerLogsCard(index: index);
                            } else {
                              if (state
                                  .listLoadingStatus.isSubmissionInProgress) {
                                return const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Center(
                                      child:
                                          CircularProgressIndicator.adaptive()),
                                );
                              } else {
                                return null;
                              }
                            }
                          },
                        ),
                      )
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
