import 'package:adb_server_manager/features/backend_details/control_operations_repo.dart';
import 'package:adb_server_manager/features/backend_details/models/start_request_model.dart';
import 'package:adb_server_manager/network_services/api_result_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'backends_control_options_event.dart';
part 'backends_control_options_state.dart';

class BackendsControlOptionsBloc
    extends Bloc<BackendsControlOptionsEvent, BackendsControlOptionsState> {
  BackendsControlOptionsBloc() : super(const BackendsControlOptionsState()) {
    ControlOperationRepo controlOperationRepo = ControlOperationRepo();
    on<OnClickOfStart>((event, emit) async {
      try {
        emit(state.copyWith(startStatus: FormzStatus.submissionInProgress));

        RepoResult? response = await controlOperationRepo.start(
          payload: StartReqModel(
                  env: Env(port: 5555),
                  execMode: "cluster",
                  script: "server.js",
                  name: event.name,
                  incrementVar: "PORT")
              .toMap(),
        );
        if (response is RepoSuccess) {
          emit(
            state.copyWith(
                startStatus: FormzStatus.submissionSuccess,
                successMsg: response.message),
          );
        } else if (response is RepoFailure) {
          emit(
            state.copyWith(
                startStatus: FormzStatus.submissionFailure,
                errorMsg: response.error.toString()),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(startStatus: FormzStatus.submissionFailure),
        );
      }
    });

    //  calling stop api logics
    on<OnClickOfStop>((event, emit) async {
      try {
        emit(state.copyWith(stopStatus: FormzStatus.submissionInProgress));

        RepoResult? response =
            await controlOperationRepo.stop(name: event.name);
        if (response is RepoSuccess) {
          emit(
            state.copyWith(
                stopStatus: FormzStatus.submissionSuccess,
                successMsg: response.message),
          );
        } else if (response is RepoFailure) {
          emit(
            state.copyWith(
                stopStatus: FormzStatus.submissionFailure,
                errorMsg: response.error.toString()),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(stopStatus: FormzStatus.submissionFailure),
        );
      }
    });

    //  calling restart logics

    on<OnClickOfRestart>((event, emit) async {
      try {
        emit(state.copyWith(restartStatus: FormzStatus.submissionInProgress));

        RepoResult? response =
            await controlOperationRepo.restart(name: event.name);
        if (response is RepoSuccess) {
          emit(
            state.copyWith(
                restartStatus: FormzStatus.submissionSuccess,
                successMsg: response.message),
          );
        } else if (response is RepoFailure) {
          emit(
            state.copyWith(
                restartStatus: FormzStatus.submissionFailure,
                errorMsg: response.error.toString()),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(restartStatus: FormzStatus.submissionFailure),
        );
      }
    });
    //  deleteApi logics is here
    on<OnClickOfDelete>((event, emit) async {
      try {
        emit(state.copyWith(deleteStatus: FormzStatus.submissionInProgress));

        RepoResult? response =
            await controlOperationRepo.delete(name: event.name);
        if (response is RepoSuccess) {
          emit(
            state.copyWith(
                deleteStatus: FormzStatus.submissionSuccess,
                successMsg: response.message),
          );
        } else if (response is RepoFailure) {
          emit(
            state.copyWith(
                deleteStatus: FormzStatus.submissionFailure,
                errorMsg: response.error.toString()),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(deleteStatus: FormzStatus.submissionFailure),
        );
      }
    });
  }
}
