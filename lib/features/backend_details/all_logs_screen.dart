import 'package:adb_server_manager/app_globle.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/features/logs/bloc/logs_bloc.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

class AllLogsScreen extends StatefulWidget {
  const AllLogsScreen({super.key});

  @override
  State<AllLogsScreen> createState() => _AllLogsScreenState();
}

class _AllLogsScreenState extends State<AllLogsScreen>
    with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;
  late Socket socket;
  @override
  void initState() {
    isLoading = true;
    setState(() {});

    socket = AppGlobals().socket;
    socket.onConnecting((data) {
      print("i am connectinggg");
      if (mounted) {
        isLoading = true;
        setState(() {});
      }
    });
    socket.onConnectError((data) {
      if (mounted) {
        isLoading = false;
        setState(() {});
      }
    });
    socket.onConnect((_) {
      socket.emit('msg', 'test');
      print("connected ==========================>>>>>>>>>>>>>>>>");
    });

    socket.open();

    socket.onDisconnect((data) => print(" i amm disconnectinngggs"));
    socket.on('connect', (_) {
      socket.emit('start-logs');
    });
    socket.on("pm2-log", (data) {
      if (mounted) {
        context.read<LogsBloc>().add(GetAllLogs(data));
        if (isLoading) {
          isLoading = false;
          setState(() {});
        }
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(
                milliseconds:
                    500), // Adjust the duration as needed if all data not covered
            curve: Curves.easeInOut,
          );
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // socket.destroy();
    socket.disconnect();
    socket.off('connect');
    socket.off('pm2-log');
    socket.off('pm2-log-error');
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogsBloc, LogsState>(
      builder: (context, state) {
        return isLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : state.allLogDataList.isEmpty
                ? const Center(
                    child: GoogleText(
                      text: AppStrings.yourListIsEmpty,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.allLogDataList.length,
                      itemBuilder: (context, index) {
                        return Text(
                          state.allLogDataList[index],
                          style: const TextStyle(
                            color: AppColors.decorationColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
                    ),
                  );
      },
    );
  }
}
