import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:sumadhura/model/visitors_model.dart';
import 'package:sumadhura/features/visitor/repo/visitor_repo.dart';

part 'visitor_state.dart';
part 'visitor_event.dart';

class VisitorBloc extends Bloc<GetVisitorsEvent, VisitorState> {
  final VisitorsRepo visitorsRepo;

  VisitorBloc({required this.visitorsRepo}) : super(VisitorInitialState()) {
    on<GetVisitorsEvent>(_onGetVisitors);
    on<DeleteVisitorsEvent>(_deleteVisitor);
    on<SearchVisitorsEvent>(
      _onSearchVisitors,
      transformer: (events, mapper) =>
          events.debounce(const Duration(milliseconds: 500)).switchMap(mapper),
    );
  }
  Future<void> _onGetVisitors(
    GetVisitorsEvent event,
    Emitter<VisitorState> emit,
  ) async {
    emit(VisitorLoadingState());
    try {
      final visitors = await visitorsRepo.getVisitors();
      emit(VisitorSuccessState(visitors: visitors));
    } catch (e) {
      emit(VisitorFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> _deleteVisitor(
    DeleteVisitorsEvent event,
    Emitter<VisitorState> emit,
  ) async {
    emit(DeleteVisitorLoadingState());
    try {
      await visitorsRepo.deleteVisitorDetails(event.visitorId);
      emit(DeleteVisitorSuccessState());
    } catch (e) {
      emit(DeleteVisitorFailureState(errorMessage: e.toString()));
    }
  }

  Future<void> _onSearchVisitors(
    SearchVisitorsEvent event,
    Emitter<VisitorState> emit,
  ) async {
    emit(VisitorLoadingState());
    try {
      final visitors = await visitorsRepo.getVisitors();
      final queryLower = event.query.toLowerCase();
      final filteredVisitors = visitors.where((visitor) {
        return visitor.name.toLowerCase().contains(queryLower) ||
            visitor.mobile.contains(queryLower);
      }).toList();
      emit(VisitorSuccessState(visitors: filteredVisitors));
    } catch (e) {
      emit(VisitorFailureState(errorMessage: e.toString()));
    }
  }
}
