import 'package:freezed_annotation/freezed_annotation.dart';

part 'vehicle_entity.freezed.dart';

@freezed
abstract class VehicleEntity with _$VehicleEntity {
  const factory VehicleEntity({
    required String remoteId,
  }) = _VehicleEntity;
}
