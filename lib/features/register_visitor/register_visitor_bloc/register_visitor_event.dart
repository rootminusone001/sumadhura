part of 'register_visitor_bloc.dart';

class VisitorEvents {}

class FetchVisitorDetailsEvent extends VisitorEvents {
  final int visitorId;

  FetchVisitorDetailsEvent({required this.visitorId});
}

class RegisterVisitorEvent extends VisitorEvents {
  final Visitors visitor;

  RegisterVisitorEvent({required this.visitor});
}

class EditVisitorEvent extends VisitorEvents {
  final Visitors visitor;

  EditVisitorEvent({required this.visitor});
}
