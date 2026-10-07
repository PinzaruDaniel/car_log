import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:injectable/injectable.dart';
import 'package:objectbox/objectbox.dart';
import '../mappers/garage_mapper.dart';
import 'legacy_garage_local_data_source.dart';
import 'models/garage_vehicle_box.dart';
import 'models/service_record_box.dart';

@lazySingleton
class GarageLocalDataSource {
  const GarageLocalDataSource(
    this._store,
    this._vehicles,
    this._records,
    this._legacy,
  );
  final Store _store;
  final Box<GarageVehicleBox> _vehicles;
  final Box<ServiceRecordBox> _records;
  final LegacyGarageLocalDataSource _legacy;

  Future<GarageVehicleEntity?> load() async {
    final existing = _vehicles.getAll();
    if (existing.isNotEmpty) return existing.first.toEntity();
    final legacy = await _legacy.load();
    if (legacy != null) await save(legacy);
    return legacy;
  }

  Future<void> save(GarageVehicleEntity vehicle) async {
    _store.runInTransaction(TxMode.write, () {
      final existing = _vehicles.getAll();
      final previous = existing.isEmpty ? null : existing.first;
      final oldIds = previous?.records.map((r) => r.id).toList() ?? <int>[];
      final next = vehicle.toBox(id: previous?.id ?? 0);
      _vehicles.put(next);
      _records.removeMany(oldIds);
    });
  }
}
