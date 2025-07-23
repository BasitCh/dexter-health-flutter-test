import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shift_handover_challenge/application/shift_handover/shift_handover_bloc.dart';
import 'package:shift_handover_challenge/application/shift_handover/shift_handover_event.dart';
import 'package:shift_handover_challenge/application/shift_handover/shift_handover_state.dart';
import 'package:shift_handover_challenge/domain/entities/shift_handover_models.dart';
import 'package:shift_handover_challenge/domain/repositories/shift_handover_repository.dart';
import 'package:dartz/dartz.dart';

class MockRepository extends Mock implements ShiftHandoverRepository {}

void main() {
  group('ShiftHandoverBloc', () {
    late MockRepository repository;
    late ShiftHandoverBloc bloc;
    final testReport = ShiftReport(
      id: 'shift-1',
      caregiverId: 'caregiver-1',
      startTime: DateTime.now(),
      notes: [],
    );

    setUp(() {
      repository = MockRepository();
      bloc = ShiftHandoverBloc(repository: repository);
    });

    blocTest<ShiftHandoverBloc, ShiftHandoverState>(
      'emits updated state when UpdateNote is added',
      build: () {
        final note = HandoverNote(
          id: 'note-1',
          text: 'Old',
          type: NoteType.observation,
          timestamp: DateTime.now(),
          authorId: 'caregiver-1',
        );
        final report = testReport.copyWith(notes: [note]);
        return ShiftHandoverBloc(repository: repository);
      },
      seed: () {
        final note = HandoverNote(
          id: 'note-1',
          text: 'Old',
          type: NoteType.observation,
          timestamp: DateTime.now(),
          authorId: 'caregiver-1',
        );
        return ShiftHandoverState(report: testReport.copyWith(notes: [note]));
      },
      act: (bloc) {
        final updated = HandoverNote(
          id: 'note-1',
          text: 'Updated',
          type: NoteType.incident,
          timestamp: DateTime.now(),
          authorId: 'caregiver-1',
        );
        bloc.add(UpdateNote(updated));
      },
      expect: () => [
        isA<ShiftHandoverState>().having((s) {
          expect(s.report, isNotNull);
          return s.report!.notes.first.text;
        }, 'text', 'Updated'),
      ],
    );

    blocTest<ShiftHandoverBloc, ShiftHandoverState>(
      'emits updated state when DeleteNote is added',
      build: () {
        final note = HandoverNote(
          id: 'note-1',
          text: 'To delete',
          type: NoteType.observation,
          timestamp: DateTime.now(),
          authorId: 'caregiver-1',
        );
        return ShiftHandoverBloc(repository: repository);
      },
      seed: () {
        final note = HandoverNote(
          id: 'note-1',
          text: 'To delete',
          type: NoteType.observation,
          timestamp: DateTime.now(),
          authorId: 'caregiver-1',
        );
        return ShiftHandoverState(report: testReport.copyWith(notes: [note]));
      },
      act: (bloc) => bloc.add(const DeleteNote('note-1')),
      expect: () => [
        isA<ShiftHandoverState>().having((s) {
          expect(s.report, isNotNull);
          return s.report!.notes;
        }, 'notes', isEmpty),
      ],
    );
  });
}
