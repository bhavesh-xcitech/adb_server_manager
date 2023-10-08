// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'backend_listing_bloc.dart';

class BackendListingState extends Equatable {
  final List<PM2ProcessInfo> backendsDataList;
  final FormzStatus formStatus;
  final String? msg;

  const BackendListingState({
    this.backendsDataList = const [],
    this.formStatus = FormzStatus.pure,
    this.msg,
  });

  @override
  List<Object?> get props => [
        msg,
        backendsDataList,
        formStatus,
      ];

  BackendListingState copyWith(
      {List<PM2ProcessInfo>? backendsDataList,
      FormzStatus? formStatus,
      String? msg}) {
    return BackendListingState(
      msg: msg ?? this.msg,
      backendsDataList: backendsDataList ?? this.backendsDataList,
      formStatus: formStatus ?? FormzStatus.pure,
    );
  }
}
