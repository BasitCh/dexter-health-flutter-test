import 'package:shift_handover_challenge/domain/entities/shift_handover_models.dart';
import 'package:shift_handover_challenge/domain/failures.dart';
import 'package:dartz/dartz.dart';

abstract class ShiftHandoverRepository {
  Future<Either<Failure, ShiftReport>> getShiftReport(String caregiverId);
  Future<Either<Failure, bool>> submitShiftReport(ShiftReport report);
}
