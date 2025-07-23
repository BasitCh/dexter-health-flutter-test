import 'package:equatable/equatable.dart';
import 'package:shift_handover_challenge/domain/entities/shift_handover_models.dart';

enum ErrorContext { none, load, submit }

class ShiftHandoverState extends Equatable {
  final ShiftReport? report;
  final bool isLoading;
  final bool isSubmitting;
  final String? error;
  final ErrorContext errorContext;
  final String inputValue;

  const ShiftHandoverState({
    this.report,
    this.isLoading = false,
    this.isSubmitting = false,
    this.error,
    this.errorContext = ErrorContext.none,
    this.inputValue = '',
  });

  ShiftHandoverState copyWith({
    ShiftReport? report,
    bool? isLoading,
    bool? isSubmitting,
    String? error,
    bool clearError = false,
    ErrorContext? errorContext,
    String? inputValue,
  }) {
    return ShiftHandoverState(
      report: report ?? this.report,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: clearError ? null : error ?? this.error,
      errorContext:
          errorContext ?? (clearError ? ErrorContext.none : this.errorContext),
      inputValue: inputValue ?? this.inputValue,
    );
  }

  @override
  List<Object?> get props =>
      [report, isLoading, isSubmitting, error, errorContext, inputValue];
}
