import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<UpdateSelectedIndex>((event, emit) {
      print("updationgg indeeexxxx");
      emit(state.copyWith(selectedIndex: event.index));
    });
  }
}
