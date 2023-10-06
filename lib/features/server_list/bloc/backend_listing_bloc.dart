import 'package:adb_server_manager/features/server_list/backend_list_repo.dart';
import 'package:adb_server_manager/features/server_list/models/pm2_env_model.dart';
import 'package:adb_server_manager/network_services/api_result_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

part 'backend_listing_event.dart';
part 'backend_listing_state.dart';

class BackendListingBloc
    extends Bloc<BackendListingEvent, BackendListingState> {
  BackendListingBloc() : super(const BackendListingState()) {
    BackendListRepo backendListRepo = BackendListRepo();
    on<InitiateListing>((event, emit) async {
      try {
        emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));


        RepoResult? response = await backendListRepo.allBackendList();

        if (response is RepoSuccess) {
          List<PM2ProcessInfo> responseList =
              (response.data as List<dynamic>).map((item) {
            return PM2ProcessInfo.fromMap(item as Map<String, dynamic>);
          }).toList();

          emit(
            state.copyWith(
                formStatus: FormzStatus.submissionSuccess,
                backendsDataList: responseList),
          );
        } else if (response is RepoFailure) {
          emit(
            state.copyWith(
                formStatus: FormzStatus.submissionFailure,
                msg: response.error.toString()),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(formStatus: FormzStatus.submissionFailure),
        );
      }
    });
  }
}
