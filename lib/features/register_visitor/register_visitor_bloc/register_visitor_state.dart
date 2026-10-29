part of 'register_visitor_bloc.dart';

class RegisterVisitorState {}

class RegisterVisitorInitialState extends RegisterVisitorState {}

class RegisterVisitorLoadingState extends RegisterVisitorState {}

class EditVisitorLoadingState extends RegisterVisitorState {}

class EditVisitorSuccessState extends RegisterVisitorState {
  final String message;
  EditVisitorSuccessState({required this.message});
}

class EditVisitorFailureState extends RegisterVisitorState {
  final String errorMessage;
  EditVisitorFailureState({required this.errorMessage});
}

class RegisterVisitorSuccessState extends RegisterVisitorState {
  final Visitors visitor;
  final String message;
  RegisterVisitorSuccessState({required this.visitor, required this.message});
}

class RegisterVisitorFailureState extends RegisterVisitorState {
  final String errorMessage;
  RegisterVisitorFailureState({required this.errorMessage});
}
