import 'package:equatable/equatable.dart';
import 'package:shift_handover_challenge/domain/entities/shift_handover_models.dart';

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

class UpdateNote extends ShiftHandoverEvent {
  final HandoverNote note;
  const UpdateNote(this.note);
}

class DeleteNote extends ShiftHandoverEvent {
  final String noteId;
  const DeleteNote(this.noteId);
}

class SubmitReport extends ShiftHandoverEvent {
  final String summary;
  const SubmitReport(this.summary);
}

class InputChanged extends ShiftHandoverEvent {
  final String input;
  const InputChanged(this.input);
}
