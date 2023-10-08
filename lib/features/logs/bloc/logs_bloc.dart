import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'logs_event.dart';
part 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  LogsBloc() : super(LogsState()) {
    on<SocketDataEvent>((event, emit) {
      List<String> updatedLogDataList = List.from(state.logDataList)
        ..add(event.data.toString());

      emit(state.copyWith(
        logDataList: updatedLogDataList,
      ));
    });
  }
}
