part of 'backend_listing_bloc.dart';

abstract class BackendListingEvent extends Equatable {
  const BackendListingEvent();

  @override
  List<Object> get props => [];
}

class InitiateListing extends BackendListingEvent {}


