import 'package:adb_server_manager/features/alert_logs/alert_logs_repo.dart';
import 'package:adb_server_manager/features/alert_logs/models/server_logs_model.dart';
import 'package:adb_server_manager/network_services/api_result_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'alerts_logs_event.dart';
part 'alerts_logs_state.dart';

class AlertsLogsBloc extends Bloc<AlertsLogsEvent, AlertsLogsState> {
  AlertsLogsBloc() : super(const AlertsLogsState()) {
    AlertLogsRepo alertLogsRepo = AlertLogsRepo();
    on<GetServerLogs>((event, emit) async {
      try {
        emit(state.copyWith(initialStatus: FormzStatus.submissionInProgress));

        RepoResult? response = await alertLogsRepo.serverLogs(
            page: state.page ?? 1, limit: state.limit ?? 10);

        if (response is RepoSuccess) {
          List<AlertLogs> responseList =
              (response.data as List<dynamic>).map((item) {
            return AlertLogs.fromMap(item as Map<String, dynamic>);
          }).toList();

          emit(
            state.copyWith(
                allServerLogs: responseList,
                initialStatus: FormzStatus.submissionSuccess),
          );
        } else if (response is RepoFailure) {
          emit(
            state.copyWith(
                initialStatus: FormzStatus.submissionFailure,
                msg: response.error.toString()),
          );
        }
      } catch (e, s) {
        print(e);
        print(s);
        emit(
          state.copyWith(initialStatus: FormzStatus.submissionFailure),
        );
      }
    });

    on<GetMoreServerLogs>((event, emit) async {
      try {
        emit(
          state.copyWith(
              listLoadingStatus: FormzStatus.submissionInProgress,
              initialStatus: FormzStatus.submissionSuccess),
        );
        // Dispatched when user wants to load more data
        final currentLogs = state.allServerLogs;
        final nextPage = (state.page ?? 1) + 1;
        RepoResult? response = await alertLogsRepo.serverLogs(
            page: nextPage, limit: state.limit ?? 10);

        if (response is RepoSuccess) {
          List<AlertLogs> nextLogs =
              (response.data as List<dynamic>).map((item) {
            return AlertLogs.fromMap(item as Map<String, dynamic>);
          }).toList();
          currentLogs.addAll(nextLogs); // Append new logs to existing ones
          emit(
            state.copyWith(
                initialStatus: FormzStatus.submissionSuccess,
                allServerLogs: currentLogs,
                page: nextPage,
                listLoadingStatus: FormzStatus.submissionSuccess),
          );
        } else if (response is RepoFailure) {
          emit(
            state.copyWith(
                listLoadingStatus: FormzStatus.submissionFailure,
                initialStatus: FormzStatus.submissionSuccess,
                msg: response.error.toString()),
          );
        }
      } catch (e, s) {
        print(e);
        print(s);
        emit(
          state.copyWith(
              listLoadingStatus: FormzStatus.submissionFailure,
              initialStatus: FormzStatus.submissionSuccess),
        );
      }
    });
  }
}
