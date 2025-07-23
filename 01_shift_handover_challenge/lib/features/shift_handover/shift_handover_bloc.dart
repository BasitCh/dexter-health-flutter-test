import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:math';

import 'shift_handover_models.dart';
import 'shift_handover_service.dart';

abstract class ShiftHandoverEvent extends Equatable {
  const ShiftHandoverEvent();
  @override
  List<Object> get props => [];
}

class LoadShiftReport extends ShiftHandoverEvent {
  final String caregiverId;
  const LoadShiftReport(this.caregiverId);
}

class AddNewNote extends ShiftHandoverEvent {
  final String text;
  final NoteType type;
  const AddNewNote(this.text, this.type);
}

class SubmitReport extends ShiftHandoverEvent {
  final String summary;
  const SubmitReport(this.summary);
}

class ShiftHandoverState extends Equatable {
  final ShiftReport? report;
  final bool isLoading;
  final bool isSubmitting;
  final String? error;

  const ShiftHandoverState({
    this.report,
    this.isLoading = false,
    this.isSubmitting = false,
    this.error,
  });

  ShiftHandoverState copyWith({
    ShiftReport? report,
    bool? isLoading,
    bool? isSubmitting,
    String? error,
    bool clearError = false,
  }) {
    return ShiftHandoverState(
      report: report ?? this.report,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: clearError ? null : error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [report, isLoading, isSubmitting, error];
}

class ShiftHandoverBloc extends Bloc<ShiftHandoverEvent, ShiftHandoverState> {
  final ShiftHandoverService _service = ShiftHandoverService();

  ShiftHandoverBloc() : super(const ShiftHandoverState()) {
    on<LoadShiftReport>(_onLoadShiftReport);
    on<AddNewNote>(_onAddNewNote);
    on<SubmitReport>(_onSubmitReport);
  }

  Future<void> _onLoadShiftReport(
    LoadShiftReport event,
    Emitter<ShiftHandoverState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final report = await _service.getShiftReport(event.caregiverId);
      emit(state.copyWith(report: report, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
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

    final updatedNotes = List<HandoverNote>.from(state.report!.notes)..add(newNote);
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
    try {
      final updatedReport = state.report!;
      updatedReport.submitReport(event.summary);

      final success = await _service.submitShiftReport(updatedReport);
      
      if (success) {
        emit(state.copyWith(report: updatedReport, isSubmitting: false));
      } else {
        emit(state.copyWith(error: 'Failed to submit report', isSubmitting: false));
      }

    } catch (e) {
      emit(state.copyWith(error: e.toString(), isSubmitting: false));
    }
  }
} 
