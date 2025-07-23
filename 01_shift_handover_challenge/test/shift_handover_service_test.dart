import 'package:flutter_test/flutter_test.dart';
import 'package:shift_handover_challenge/data/shift_handover_service.dart';
import 'package:shift_handover_challenge/domain/entities/shift_handover_models.dart';

void main() {
  group('ShiftHandoverService', () {
    final service = ShiftHandoverService();

    test('getShiftReport returns a ShiftReport with notes', () async {
      final report = await service.getShiftReport('caregiver-1');
      expect(report, isA<ShiftReport>());
      expect(report.notes, isNotEmpty);
    });

    test('submitShiftReport returns true or throws', () async {
      final report = await service.getShiftReport('caregiver-1');
      try {
        final result = await service.submitShiftReport(report);
        expect(result, isTrue);
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });
}
