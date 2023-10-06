import 'package:adb_server_manager/common_widgets/app_bar.dart';
import 'package:adb_server_manager/common_widgets/app_text.dart';
import 'package:adb_server_manager/features/server_list/bloc/backend_listing_bloc.dart';
import 'package:adb_server_manager/features/server_list/widgets/backend_data_box.dart';
import 'package:adb_server_manager/resource/app_colors.dart';
import 'package:adb_server_manager/resource/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class BackendsListingScreen extends StatefulWidget {
  const BackendsListingScreen({
    super.key,
  });

  @override
  State<BackendsListingScreen> createState() => _BackendsListingScreenState();
}

class _BackendsListingScreenState extends State<BackendsListingScreen> {
  // void connectAndListen() {
  //   print("function callled ");
  //   var socket = io.io('http://192.168.29.170:8080', <String, dynamic>{
  //     'transports': ['websocket'], // Use WebSocket transport
  //     // 'autoConnect': false,
  //     // 'query': 'EIO=4&transport=polling',
  //     // 'forceNew': true,
  //   });
  //   socket.onConnect((_) {
  //     print('connect');
  //     socket.emit('msg', 'test');
  //   });

  //   //When an event recieved from server, data is added to the stream
  //   socket.on('pm2-log', (data) {
  //     streamSocket.addResponse;
  //     print(data);
  //   });
  //   socket.on('pm2-log-error', (data) => streamSocket.addResponse);
  //   // socket.on('pm2-log', (data) {
  //   //   print(data);
  //   //   // print("lalalaalalla");
  //   //   setState(() {
  //   //     logTextController.text += data + '\n'; // Update log messages in your UI
  //   //   });
  //   // });

  //   // socket.on('pm2-log-error', (data) {
  //   //   print("pm2 errrorrr is called");
  //   //   setState(() {
  //   //     logTextController.text +=
  //   //         data + '\n'; // Update error messages in your UI
  //   //   });
  //   // });
  //   socket.onDisconnect((_) => print('disconnect'));
  // }

  // BackendListingBloc backendListingBloc = BackendListingBloc();
  @override
  void initState() {
    // TODO: implement initState
    // connectAndListen();
    context.read<BackendListingBloc>().add(InitiateListing());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CommonAppBar(
          text: AppStrings.serverListing, isNeedBackBtn: false),
      body: SafeArea(
        child: BlocListener<BackendListingBloc, BackendListingState>(
          listener: (context, state) {
            print("statetettee issisis");
            print(state.formStatus);
            // TODO: implement listener
          },
          child: BlocBuilder<BackendListingBloc, BackendListingState>(
            builder: (context, state) {
              return state.formStatus.isSubmissionInProgress
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : state.formStatus.isSubmissionSuccess
                      ? state.backendsDataList.isEmpty
                          ? const Center(
                              child: GoogleText(
                                text: AppStrings.yourListIsEmpty,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  context
                                      .read<BackendListingBloc>()
                                      .add(InitiateListing());
                                },
                                child: ListView.builder(
                                  itemCount: state.backendsDataList.length,
                                  itemBuilder: (context, index) {
                                    return BackendDataBox(
                                        index: index,
                                        pm2Data: state.backendsDataList[index]
                                        // PM2ProcessInfo(
                                        //     pm2Env: Pm2Env(
                                        //       status: "online",
                                        //       createdAt: 7834578,
                                        //     ),
                                        //     name: "api name"),
                                        );
                                  },
                                ),
                              ))
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
      ),
    );
  }
}
