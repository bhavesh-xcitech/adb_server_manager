import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'logs_event.dart';
part 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  LogsBloc() : super(const LogsState()) {
    on<SocketDataEvent>((event, emit) {
      List<String> updatedLogDataList = List.from(state.logDataList)
        ..add(event.data.toString());

      emit(state.copyWith(
        logDataList: updatedLogDataList,
      ));
    });
    on<ClearIndividualLogs>((event, emit) {
      if (state.logDataList.isNotEmpty) {
        state.logDataList.clear();
      }
      emit(state.copyWith(logDataList: []));
    });
    on<ClearAllLogs>((event, emit) {
      if (state.allLogDataList.isNotEmpty) {
        state.allLogDataList.clear();
        emit(state.copyWith(allLogDataList: []));
      }
    });

    on<GetAllLogs>((event, emit) {
      List<String> updatedLogDataList = List.from(state.allLogDataList)
        ..add(event.data.toString());

      emit(state.copyWith(
        allLogDataList: updatedLogDataList,
      ));
    });
  }
}
