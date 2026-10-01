import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:domain/features/garage/entities/service_record.dart';
import '../local/models/garage_vehicle_box.dart';
import '../local/models/service_record_box.dart';

extension GarageVehicleBoxMapper on GarageVehicleBox {
  GarageVehicle toEntity() => GarageVehicle(
    make: make,
    model: model,
    year: year,
    odometer: odometer,
    vin: vin,
    body: body,
    fuel: fuel,
    engine: engine,
    oilInterval: oilInterval,
    insuranceExpiry: insuranceExpiry,
    records: records.map((record) => record.toEntity()).toList(),
  );
}

extension GarageVehicleEntityMapper on GarageVehicle {
  GarageVehicleBox toBox({int id = 0}) {
    final box = GarageVehicleBox(
      id: id,
      make: make,
      model: model,
      year: year,
      odometer: odometer,
      vin: vin,
      body: body,
      fuel: fuel,
      engine: engine,
      oilInterval: oilInterval,
      insuranceExpiry: insuranceExpiry,
    );
    box.records.addAll(records.map((record) => record.toBox()));
    return box;
  }
}

extension ServiceRecordBoxMapper on ServiceRecordBox {
  ServiceRecord toEntity() => ServiceRecord(
    title: title,
    date: date,
    km: km,
    kind: ServiceKind.values.byName(kindName),
    cost: cost,
    notes: notes,
    oil: oil,
  );
}

extension ServiceRecordEntityMapper on ServiceRecord {
  ServiceRecordBox toBox() => ServiceRecordBox(
    title: title,
    date: date,
    km: km,
    kindName: kind.name,
    cost: cost,
    notes: notes,
    oil: oil,
  );
}
