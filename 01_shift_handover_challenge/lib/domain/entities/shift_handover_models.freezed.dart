// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shift_handover_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HandoverNote _$HandoverNoteFromJson(Map<String, dynamic> json) {
  return _HandoverNote.fromJson(json);
}

/// @nodoc
mixin _$HandoverNote {
  String get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  NoteType get type => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  List<String> get taggedResidentIds => throw _privateConstructorUsedError;
  bool get isAcknowledged => throw _privateConstructorUsedError;

  /// Serializes this HandoverNote to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HandoverNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HandoverNoteCopyWith<HandoverNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HandoverNoteCopyWith<$Res> {
  factory $HandoverNoteCopyWith(
          HandoverNote value, $Res Function(HandoverNote) then) =
      _$HandoverNoteCopyWithImpl<$Res, HandoverNote>;
  @useResult
  $Res call(
      {String id,
      String text,
      NoteType type,
      DateTime timestamp,
      String authorId,
      List<String> taggedResidentIds,
      bool isAcknowledged});
}

/// @nodoc
class _$HandoverNoteCopyWithImpl<$Res, $Val extends HandoverNote>
    implements $HandoverNoteCopyWith<$Res> {
  _$HandoverNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HandoverNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? type = null,
    Object? timestamp = null,
    Object? authorId = null,
    Object? taggedResidentIds = null,
    Object? isAcknowledged = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoteType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      taggedResidentIds: null == taggedResidentIds
          ? _value.taggedResidentIds
          : taggedResidentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isAcknowledged: null == isAcknowledged
          ? _value.isAcknowledged
          : isAcknowledged // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HandoverNoteImplCopyWith<$Res>
    implements $HandoverNoteCopyWith<$Res> {
  factory _$$HandoverNoteImplCopyWith(
          _$HandoverNoteImpl value, $Res Function(_$HandoverNoteImpl) then) =
      __$$HandoverNoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String text,
      NoteType type,
      DateTime timestamp,
      String authorId,
      List<String> taggedResidentIds,
      bool isAcknowledged});
}

/// @nodoc
class __$$HandoverNoteImplCopyWithImpl<$Res>
    extends _$HandoverNoteCopyWithImpl<$Res, _$HandoverNoteImpl>
    implements _$$HandoverNoteImplCopyWith<$Res> {
  __$$HandoverNoteImplCopyWithImpl(
      _$HandoverNoteImpl _value, $Res Function(_$HandoverNoteImpl) _then)
      : super(_value, _then);

  /// Create a copy of HandoverNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? type = null,
    Object? timestamp = null,
    Object? authorId = null,
    Object? taggedResidentIds = null,
    Object? isAcknowledged = null,
  }) {
    return _then(_$HandoverNoteImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NoteType,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      taggedResidentIds: null == taggedResidentIds
          ? _value._taggedResidentIds
          : taggedResidentIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isAcknowledged: null == isAcknowledged
          ? _value.isAcknowledged
          : isAcknowledged // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HandoverNoteImpl implements _HandoverNote {
  const _$HandoverNoteImpl(
      {required this.id,
      required this.text,
      required this.type,
      required this.timestamp,
      required this.authorId,
      final List<String> taggedResidentIds = const [],
      this.isAcknowledged = false})
      : _taggedResidentIds = taggedResidentIds;

  factory _$HandoverNoteImpl.fromJson(Map<String, dynamic> json) =>
      _$$HandoverNoteImplFromJson(json);

  @override
  final String id;
  @override
  final String text;
  @override
  final NoteType type;
  @override
  final DateTime timestamp;
  @override
  final String authorId;
  final List<String> _taggedResidentIds;
  @override
  @JsonKey()
  List<String> get taggedResidentIds {
    if (_taggedResidentIds is EqualUnmodifiableListView)
      return _taggedResidentIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_taggedResidentIds);
  }

  @override
  @JsonKey()
  final bool isAcknowledged;

  @override
  String toString() {
    return 'HandoverNote(id: $id, text: $text, type: $type, timestamp: $timestamp, authorId: $authorId, taggedResidentIds: $taggedResidentIds, isAcknowledged: $isAcknowledged)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HandoverNoteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            const DeepCollectionEquality()
                .equals(other._taggedResidentIds, _taggedResidentIds) &&
            (identical(other.isAcknowledged, isAcknowledged) ||
                other.isAcknowledged == isAcknowledged));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      text,
      type,
      timestamp,
      authorId,
      const DeepCollectionEquality().hash(_taggedResidentIds),
      isAcknowledged);

  /// Create a copy of HandoverNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HandoverNoteImplCopyWith<_$HandoverNoteImpl> get copyWith =>
      __$$HandoverNoteImplCopyWithImpl<_$HandoverNoteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HandoverNoteImplToJson(
      this,
    );
  }
}

abstract class _HandoverNote implements HandoverNote {
  const factory _HandoverNote(
      {required final String id,
      required final String text,
      required final NoteType type,
      required final DateTime timestamp,
      required final String authorId,
      final List<String> taggedResidentIds,
      final bool isAcknowledged}) = _$HandoverNoteImpl;

  factory _HandoverNote.fromJson(Map<String, dynamic> json) =
      _$HandoverNoteImpl.fromJson;

  @override
  String get id;
  @override
  String get text;
  @override
  NoteType get type;
  @override
  DateTime get timestamp;
  @override
  String get authorId;
  @override
  List<String> get taggedResidentIds;
  @override
  bool get isAcknowledged;

  /// Create a copy of HandoverNote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HandoverNoteImplCopyWith<_$HandoverNoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ShiftReport _$ShiftReportFromJson(Map<String, dynamic> json) {
  return _ShiftReport.fromJson(json);
}

/// @nodoc
mixin _$ShiftReport {
  String get id => throw _privateConstructorUsedError;
  String get caregiverId => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  List<HandoverNote> get notes => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  bool get isSubmitted => throw _privateConstructorUsedError;

  /// Serializes this ShiftReport to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShiftReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShiftReportCopyWith<ShiftReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShiftReportCopyWith<$Res> {
  factory $ShiftReportCopyWith(
          ShiftReport value, $Res Function(ShiftReport) then) =
      _$ShiftReportCopyWithImpl<$Res, ShiftReport>;
  @useResult
  $Res call(
      {String id,
      String caregiverId,
      DateTime startTime,
      DateTime? endTime,
      List<HandoverNote> notes,
      String summary,
      bool isSubmitted});
}

/// @nodoc
class _$ShiftReportCopyWithImpl<$Res, $Val extends ShiftReport>
    implements $ShiftReportCopyWith<$Res> {
  _$ShiftReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShiftReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? caregiverId = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? notes = null,
    Object? summary = null,
    Object? isSubmitted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      caregiverId: null == caregiverId
          ? _value.caregiverId
          : caregiverId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<HandoverNote>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      isSubmitted: null == isSubmitted
          ? _value.isSubmitted
          : isSubmitted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ShiftReportImplCopyWith<$Res>
    implements $ShiftReportCopyWith<$Res> {
  factory _$$ShiftReportImplCopyWith(
          _$ShiftReportImpl value, $Res Function(_$ShiftReportImpl) then) =
      __$$ShiftReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String caregiverId,
      DateTime startTime,
      DateTime? endTime,
      List<HandoverNote> notes,
      String summary,
      bool isSubmitted});
}

/// @nodoc
class __$$ShiftReportImplCopyWithImpl<$Res>
    extends _$ShiftReportCopyWithImpl<$Res, _$ShiftReportImpl>
    implements _$$ShiftReportImplCopyWith<$Res> {
  __$$ShiftReportImplCopyWithImpl(
      _$ShiftReportImpl _value, $Res Function(_$ShiftReportImpl) _then)
      : super(_value, _then);

  /// Create a copy of ShiftReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? caregiverId = null,
    Object? startTime = null,
    Object? endTime = freezed,
    Object? notes = null,
    Object? summary = null,
    Object? isSubmitted = null,
  }) {
    return _then(_$ShiftReportImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      caregiverId: null == caregiverId
          ? _value.caregiverId
          : caregiverId // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      notes: null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<HandoverNote>,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      isSubmitted: null == isSubmitted
          ? _value.isSubmitted
          : isSubmitted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ShiftReportImpl implements _ShiftReport {
  const _$ShiftReportImpl(
      {required this.id,
      required this.caregiverId,
      required this.startTime,
      this.endTime,
      final List<HandoverNote> notes = const [],
      this.summary = '',
      this.isSubmitted = false})
      : _notes = notes;

  factory _$ShiftReportImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShiftReportImplFromJson(json);

  @override
  final String id;
  @override
  final String caregiverId;
  @override
  final DateTime startTime;
  @override
  final DateTime? endTime;
  final List<HandoverNote> _notes;
  @override
  @JsonKey()
  List<HandoverNote> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
  }

  @override
  @JsonKey()
  final String summary;
  @override
  @JsonKey()
  final bool isSubmitted;

  @override
  String toString() {
    return 'ShiftReport(id: $id, caregiverId: $caregiverId, startTime: $startTime, endTime: $endTime, notes: $notes, summary: $summary, isSubmitted: $isSubmitted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShiftReportImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.caregiverId, caregiverId) ||
                other.caregiverId == caregiverId) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            const DeepCollectionEquality().equals(other._notes, _notes) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.isSubmitted, isSubmitted) ||
                other.isSubmitted == isSubmitted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      caregiverId,
      startTime,
      endTime,
      const DeepCollectionEquality().hash(_notes),
      summary,
      isSubmitted);

  /// Create a copy of ShiftReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShiftReportImplCopyWith<_$ShiftReportImpl> get copyWith =>
      __$$ShiftReportImplCopyWithImpl<_$ShiftReportImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ShiftReportImplToJson(
      this,
    );
  }
}

abstract class _ShiftReport implements ShiftReport {
  const factory _ShiftReport(
      {required final String id,
      required final String caregiverId,
      required final DateTime startTime,
      final DateTime? endTime,
      final List<HandoverNote> notes,
      final String summary,
      final bool isSubmitted}) = _$ShiftReportImpl;

  factory _ShiftReport.fromJson(Map<String, dynamic> json) =
      _$ShiftReportImpl.fromJson;

  @override
  String get id;
  @override
  String get caregiverId;
  @override
  DateTime get startTime;
  @override
  DateTime? get endTime;
  @override
  List<HandoverNote> get notes;
  @override
  String get summary;
  @override
  bool get isSubmitted;

  /// Create a copy of ShiftReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShiftReportImplCopyWith<_$ShiftReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
