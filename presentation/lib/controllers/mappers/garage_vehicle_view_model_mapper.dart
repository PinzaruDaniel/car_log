import 'package:domain/features/garage/entities/garage_vehicle.dart';
import 'package:domain/features/garage/entities/service_record.dart';

import '../../view_models/garage_vehicle_view_model.dart';

extension GarageVehicleViewModelMapper on GarageVehicleEntity {
  GarageVehicleViewModel toViewModel() => GarageVehicleViewModel(
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
    records: records
        .map(
          (record) => ServiceRecordViewModel(
            title: record.title,
            date: record.date,
            km: record.km,
            kind: record.kind.toViewModel(),
            cost: record.cost,
            notes: record.notes,
            oil: record.oil,
          ),
        )
        .toList(growable: false),
  );
}

extension GarageVehicleEntityMapper on GarageVehicleViewModel {
  GarageVehicleEntity toEntity() => GarageVehicleEntity(
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
    records: records
        .map(
          (record) => ServiceRecordEntity(
            title: record.title,
            date: record.date,
            km: record.km,
            kind: record.kind.toEntity(),
            cost: record.cost,
            notes: record.notes,
            oil: record.oil,
          ),
        )
        .toList(growable: false),
  );
}

extension ServiceKindViewModelMapper on ServiceKind {
  ServiceKindViewModel toViewModel() => switch (this) {
    ServiceKind.maintenance => ServiceKindViewModel.maintenance,
    ServiceKind.repair => ServiceKindViewModel.repair,
    ServiceKind.fuel => ServiceKindViewModel.fuel,
  };
}

extension ServiceKindEntityMapper on ServiceKindViewModel {
  ServiceKind toEntity() => switch (this) {
    ServiceKindViewModel.maintenance => ServiceKind.maintenance,
    ServiceKindViewModel.repair => ServiceKind.repair,
    ServiceKindViewModel.fuel => ServiceKind.fuel,
  };
}
