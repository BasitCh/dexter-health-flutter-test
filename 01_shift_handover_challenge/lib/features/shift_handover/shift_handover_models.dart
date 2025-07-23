import 'package:flutter/material.dart';

enum NoteType {
  observation,
  incident,
  medication,
  task,
  supplyRequest,
}

class HandoverNote {
  String id;
  String text;
  NoteType type;
  DateTime timestamp;
  String authorId;
  List<String> taggedResidentIds;
  bool isAcknowledged = false;

  HandoverNote({
    required this.id,
    required this.text,
    required this.type,
    required this.timestamp,
    required this.authorId,
    this.taggedResidentIds = const [],
  });

  void acknowledge() {
    isAcknowledged = true;
  }

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

class ShiftReport {
  String id;
  String caregiverId;
  DateTime startTime;
  DateTime? endTime;
  List<HandoverNote> notes;
  String summary;
  bool isSubmitted = false;

  ShiftReport({
    required this.id,
    required this.caregiverId,
    required this.startTime,
    this.endTime,
    this.notes = const [],
    this.summary = '',
  });

  void addNote(HandoverNote note) {
    notes.add(note);
  }

  void submitReport(String summary) {
    this.summary = summary;
    endTime = DateTime.now();
    isSubmitted = true;
  }
}
