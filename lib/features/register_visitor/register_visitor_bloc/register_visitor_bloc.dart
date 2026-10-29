import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sumadhura/features/visitor/repo/visitor_repo.dart';
import 'package:sumadhura/model/visitors_model.dart';

part 'register_visitor_event.dart';
part 'register_visitor_state.dart';

class RegisterVisitorBloc extends Bloc<VisitorEvents, RegisterVisitorState> {
  final VisitorsRepo visitorsRepo;
  RegisterVisitorBloc({required this.visitorsRepo})
    : super(RegisterVisitorInitialState()) {
    on<RegisterVisitorEvent>(_registerVisitor);
    on<EditVisitorEvent>(_editVisitor);
    on<FetchVisitorDetailsEvent>(_fetchVisitorDetails);
  }

  Future<void> _registerVisitor(
    RegisterVisitorEvent event,
    Emitter<RegisterVisitorState> emit,
  ) async {
    emit(RegisterVisitorLoadingState());
    try {
      await Future.delayed(Duration(seconds: 2));
      Visitors visitorData = event.visitor;
      visitorData = visitorData.copyWith(
        createdAt: DateTime.now().toIso8601String(),
      );
      final Visitors registeredVisitor = await visitorsRepo.registerVisitors(
        visitorData,
      );
      emit(
        RegisterVisitorSuccessState(
          visitor: registeredVisitor,
          message: "Visitor registered successfully",
        ),
      );
    } catch (e) {
      emit(RegisterVisitorFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> _editVisitor(
    EditVisitorEvent event,
    Emitter<RegisterVisitorState> emit,
  ) async {
    emit(EditVisitorLoadingState());
    try {
      Visitors editVisitorData = event.visitor;
      if (editVisitorData.status == 'Checked In' &&
          (editVisitorData.checkInTime == null ||
              editVisitorData.checkInTime!.isEmpty)) {
        editVisitorData = editVisitorData.copyWith(
          checkInTime: DateTime.now().toIso8601String(),
        );
      } else if (editVisitorData.status == 'Checked Out' &&
          (editVisitorData.checkOutTime == null ||
              editVisitorData.checkOutTime!.isEmpty)) {
        editVisitorData = editVisitorData.copyWith(
          checkOutTime: DateTime.now().toIso8601String(),
        );
      }
      await visitorsRepo.editVisitors(editVisitorData);
      emit(EditVisitorSuccessState(message: 'Edited details suyccessfully'));
    } catch (e) {
      emit(EditVisitorFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> _fetchVisitorDetails(
    FetchVisitorDetailsEvent event,
    Emitter<RegisterVisitorState> emit,
  ) async {
    emit(RegisterVisitorLoadingState());
    try {
      final visitor = await visitorsRepo.getVisitorDetails(event.visitorId);
      if (visitor != null) {
        emit(
          RegisterVisitorSuccessState(
            visitor: visitor,
            message: "Visitor details fetched successfully",
          ),
        );
      }
    } catch (e) {
      emit(RegisterVisitorFailureState(errorMessage: e.toString()));
    }
  }
}
