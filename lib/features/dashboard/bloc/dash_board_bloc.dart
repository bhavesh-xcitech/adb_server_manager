import 'package:adb_server_manager/features/dashboard/dashboard_letest_log_model.dart';
import 'package:adb_server_manager/features/dashboard/dashboard_repo.dart';
import 'package:adb_server_manager/network_services/api_result_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'dash_board_event.dart';
part 'dash_board_state.dart';

class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
  DashBoardBloc() : super(const DashBoardState()) {
    DashBoardRepo dashBoardRepo = DashBoardRepo();
    on<GetDashBoardData>((event, emit) async {
      try {
        emit(state.copyWith(formStatus: FormzStatus.submissionInProgress));

        RepoResult? response = await dashBoardRepo.getDashBoardStatus();

        if (response is RepoSuccess) {
          List<DashBoardLogs> responseList =
              (response.data as List<dynamic>).map((item) {
            return DashBoardLogs.fromMap(item as Map<String, dynamic>);
          }).toList();
          print(response.data);
          emit(
            state.copyWith(
                formStatus: FormzStatus.submissionSuccess,
                dashboardList: responseList),
          );
        } else if (response is RepoFailure) {
          emit(
            state.copyWith(
                formStatus: FormzStatus.submissionFailure,
                msg: response.error.toString()),
          );
        }
      } catch (e, s) {
        print(e);
        print(s);
        emit(
          state.copyWith(formStatus: FormzStatus.submissionFailure),
        );
      }
    });
  }
}
