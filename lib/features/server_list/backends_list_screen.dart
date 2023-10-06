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
  @override
  void initState() {
    context.read<BackendListingBloc>().add(InitiateListing());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CommonAppBar(
          text: AppStrings.adbMonitor, isNeedBackBtn: false),
      body: SafeArea(
        child: BlocListener<BackendListingBloc, BackendListingState>(
          listener: (context, state) {},
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
                                        pm2Data: state.backendsDataList[index]);
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
