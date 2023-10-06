// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'backend_listing_bloc.dart';

class BackendListingState extends Equatable {
  final List<PM2ProcessInfo> backendsDataList;
  final FormzStatus formStatus;
  final String? msg;
  final io.Socket? socket;
  final String? logData;
  final List logDataList;
  const BackendListingState({
    this.backendsDataList = const [],
    this.formStatus = FormzStatus.pure,
    this.msg,
     this.socket,
    this.logData,
    this.logDataList = const [],
  });

  @override
  List<Object?> get props =>
      [msg, backendsDataList, formStatus, logData , logDataList];

  BackendListingState copyWith(
      {List<PM2ProcessInfo>? backendsDataList,
      FormzStatus? formStatus,
      io.Socket? socket,
      String? logData,
      List? logDataList,
      String? msg}) {
    return BackendListingState(
      logDataList: logDataList ?? this.logDataList,
      logData: logData ??
          this.logData,
      socket: socket ?? this.socket,
      msg: msg ?? this.msg,
      backendsDataList: backendsDataList ?? this.backendsDataList,
      formStatus: formStatus ?? FormzStatus.pure,
    );
  }
}
