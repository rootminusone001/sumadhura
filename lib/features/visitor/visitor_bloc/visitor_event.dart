part of 'visitor_bloc.dart';

class GetVisitorsEvent {}

class SearchVisitorsEvent extends GetVisitorsEvent {
  final String query;
  SearchVisitorsEvent({required this.query});
}

class DeleteVisitorsEvent extends GetVisitorsEvent {
  final int? visitorId;
  DeleteVisitorsEvent({required this.visitorId});
}
