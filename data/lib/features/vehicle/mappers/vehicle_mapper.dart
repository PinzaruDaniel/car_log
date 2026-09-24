import 'package:domain/features/vehicle/entities/vehicle_entity.dart';
import '../local/models/vehicle_box.dart';
import '../remote/models/vehicle_dto.dart';

extension VehicleDtoMapper on VehicleDto {
  VehicleEntity toEntity() {
    return VehicleEntity(remoteId: id);
  }

  VehicleBox toBox() {
    return VehicleBox(remoteId: id);
  }
}

extension VehicleBoxMapper on VehicleBox {
  VehicleEntity toEntity() {
    return VehicleEntity(remoteId: remoteId);
  }
}
