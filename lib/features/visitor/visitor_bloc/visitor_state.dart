part of 'visitor_bloc.dart';

class VisitorState {}

class VisitorInitialState extends VisitorState {}

class VisitorLoadingState extends VisitorState {}

class VisitorSuccessState extends VisitorState {
  final List<Visitors> visitors;
  VisitorSuccessState({required this.visitors});
}

class VisitorFailureState extends VisitorState {
  final String errorMessage;
  VisitorFailureState({required this.errorMessage});
}

class DeleteVisitorLoadingState extends VisitorState {}

class DeleteVisitorSuccessState extends VisitorState {}

class DeleteVisitorFailureState extends VisitorState {
  final String errorMessage;
  DeleteVisitorFailureState({required this.errorMessage});
}
