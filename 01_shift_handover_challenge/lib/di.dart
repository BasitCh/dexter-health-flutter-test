import 'package:get_it/get_it.dart';
import 'package:shift_handover_challenge/data/shift_handover_service.dart';
import 'package:shift_handover_challenge/domain/repositories/shift_handover_repository.dart';
import 'package:shift_handover_challenge/data/shift_handover_repository_impl.dart';

final sl = GetIt.instance;

void setupDI() {
  sl.registerLazySingleton<ShiftHandoverService>(() => ShiftHandoverService());
  sl.registerLazySingleton<ShiftHandoverRepository>(
    () => ShiftHandoverRepositoryImpl(sl()),
  );
}
