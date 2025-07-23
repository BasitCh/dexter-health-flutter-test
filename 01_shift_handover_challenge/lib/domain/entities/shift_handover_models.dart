import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'shift_handover_models.freezed.dart';
part 'shift_handover_models.g.dart';

enum NoteType {
  observation,
  incident,
  medication,
  task,
  supplyRequest,
}

@freezed
class HandoverNote with _$HandoverNote {
  const factory HandoverNote({
    required String id,
    required String text,
    required NoteType type,
    required DateTime timestamp,
    required String authorId,
    @Default([]) List<String> taggedResidentIds,
    @Default(false) bool isAcknowledged,
  }) = _HandoverNote;

  factory HandoverNote.fromJson(Map<String, dynamic> json) =>
      _$HandoverNoteFromJson(json);
}

extension HandoverNoteColor on HandoverNote {
  Color getColor() {
    switch (type) {
      case NoteType.incident:
        return Colors.red.shade100;
      case NoteType.supplyRequest:
        return Colors.yellow.shade100;
      case NoteType.observation:
      default:
        return Colors.blue.shade100;
    }
  }
}

@freezed
class ShiftReport with _$ShiftReport {
  const factory ShiftReport({
    required String id,
    required String caregiverId,
    required DateTime startTime,
    DateTime? endTime,
    @Default([]) List<HandoverNote> notes,
    @Default('') String summary,
    @Default(false) bool isSubmitted,
  }) = _ShiftReport;

  factory ShiftReport.fromJson(Map<String, dynamic> json) =>
      _$ShiftReportFromJson(json);
}
