import 'package:shift_handover_challenge/domain/entities/shift_handover_models.dart';
import 'package:shift_handover_challenge/domain/repositories/shift_handover_repository.dart';
import 'package:shift_handover_challenge/data/shift_handover_service.dart';
import 'package:shift_handover_challenge/domain/failures.dart';
import 'package:dartz/dartz.dart';

class ShiftHandoverRepositoryImpl implements ShiftHandoverRepository {
  final ShiftHandoverService service;

  ShiftHandoverRepositoryImpl(this.service);

  @override
  Future<Either<Failure, ShiftReport>> getShiftReport(
      String caregiverId) async {
    try {
      final report = await service.getShiftReport(caregiverId);
      return right(report);
    } catch (e) {
      return left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> submitShiftReport(ShiftReport report) async {
    try {
      final result = await service.submitShiftReport(report);
      return right(result);
    } catch (e) {
      if (e.toString().contains('Network error')) {
        return left(NetworkFailure(e.toString()));
      }
      return left(UnexpectedFailure(e.toString()));
    }
  }
}
