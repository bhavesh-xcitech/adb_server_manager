// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final PackageInfo? packageInfo;

  const HomeState({
    this.selectedIndex = 0,
    this.packageInfo,
  });

  @override
  List<Object> get props => [selectedIndex];

  HomeState copyWith({
    int? selectedIndex,
    PackageInfo? packageInfo,
  }) {
    return HomeState(
        selectedIndex: selectedIndex ?? this.selectedIndex,
        packageInfo: packageInfo ?? this.packageInfo);
  }
}
