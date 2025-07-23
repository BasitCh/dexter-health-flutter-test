// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shift_handover_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HandoverNoteImpl _$$HandoverNoteImplFromJson(Map<String, dynamic> json) =>
    _$HandoverNoteImpl(
      id: json['id'] as String,
      text: json['text'] as String,
      type: $enumDecode(_$NoteTypeEnumMap, json['type']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      authorId: json['authorId'] as String,
      taggedResidentIds: (json['taggedResidentIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isAcknowledged: json['isAcknowledged'] as bool? ?? false,
    );

Map<String, dynamic> _$$HandoverNoteImplToJson(_$HandoverNoteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'type': _$NoteTypeEnumMap[instance.type]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'authorId': instance.authorId,
      'taggedResidentIds': instance.taggedResidentIds,
      'isAcknowledged': instance.isAcknowledged,
    };

const _$NoteTypeEnumMap = {
  NoteType.observation: 'observation',
  NoteType.incident: 'incident',
  NoteType.medication: 'medication',
  NoteType.task: 'task',
  NoteType.supplyRequest: 'supplyRequest',
};

_$ShiftReportImpl _$$ShiftReportImplFromJson(Map<String, dynamic> json) =>
    _$ShiftReportImpl(
      id: json['id'] as String,
      caregiverId: json['caregiverId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      notes: (json['notes'] as List<dynamic>?)
              ?.map((e) => HandoverNote.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      summary: json['summary'] as String? ?? '',
      isSubmitted: json['isSubmitted'] as bool? ?? false,
    );

Map<String, dynamic> _$$ShiftReportImplToJson(_$ShiftReportImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'caregiverId': instance.caregiverId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'notes': instance.notes,
      'summary': instance.summary,
      'isSubmitted': instance.isSubmitted,
    };
