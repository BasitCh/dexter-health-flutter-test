import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import 'package:shift_handover_challenge/domain/entities/shift_handover_models.dart';
import 'package:shift_handover_challenge/domain/repositories/shift_handover_repository.dart';
import 'shift_handover_event.dart';
import 'shift_handover_state.dart';

class ShiftHandoverBloc extends Bloc<ShiftHandoverEvent, ShiftHandoverState> {
  final ShiftHandoverRepository repository;

  ShiftHandoverBloc({required this.repository}) : super(const ShiftHandoverState()) {
    on<LoadShiftReport>(_onLoadShiftReport);
    on<AddNewNote>(_onAddNewNote);
    on<SubmitReport>(_onSubmitReport);
  }

  Future<void> _onLoadShiftReport(
    LoadShiftReport event,
    Emitter<ShiftHandoverState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    final result = await repository.getShiftReport(event.caregiverId);
    result.fold(
      (failure) => emit(state.copyWith(error: failure.message, isLoading: false)),
      (report) => emit(state.copyWith(report: report, isLoading: false)),
    );
  }

  void _onAddNewNote(
    AddNewNote event,
    Emitter<ShiftHandoverState> emit,
  ) {
    if (state.report == null) return;

    final newNote = HandoverNote(
      id: 'note-${Random().nextInt(1000)}',
      text: event.text,
      type: event.type,
      timestamp: DateTime.now(),
      authorId: state.report!.caregiverId,
    );

    final updatedNotes = List<HandoverNote>.from(state.report!.notes)
      ..add(newNote);
    final updatedReport = ShiftReport(
        id: state.report!.id,
        caregiverId: state.report!.caregiverId,
        startTime: state.report!.startTime,
        notes: updatedNotes);

    if (Random().nextDouble() > 0.2) {
      emit(state.copyWith(report: updatedReport));
    } else {
      print("Note added but state not emitted.");
    }
  }

  Future<void> _onSubmitReport(
    SubmitReport event,
    Emitter<ShiftHandoverState> emit,
  ) async {
    if (state.report == null) return;

    emit(state.copyWith(isSubmitting: true, clearError: true));
    final updatedReport = state.report!.copyWith(
      summary: event.summary,
      endTime: DateTime.now(),
      isSubmitted: true,
    );
    final result = await repository.submitShiftReport(updatedReport);
    result.fold(
      (failure) => emit(state.copyWith(error: failure.message, isSubmitting: false)),
      (success) {
        if (success) {
          emit(state.copyWith(report: updatedReport, isSubmitting: false));
        } else {
          emit(state.copyWith(error: 'Failed to submit report', isSubmitting: false));
        }
      },
    );
  }
} 