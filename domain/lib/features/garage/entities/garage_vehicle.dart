import 'package:freezed_annotation/freezed_annotation.dart';
import 'service_record.dart';

part 'garage_vehicle.freezed.dart';
part 'garage_vehicle.g.dart';

@freezed
abstract class GarageVehicleEntity with _$GarageVehicleEntity {
  const GarageVehicleEntity._();

  // Freezed forwards this annotation to the generated implementation.
  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory GarageVehicleEntity({
    required String make,
    required String model,
    required int year,
    required int odometer,
    @Default('') String vin,
    @Default('') String body,
    @Default('') String fuel,
    @Default('') String engine,
    @Default(10000) int oilInterval,
    DateTime? insuranceExpiry,
    @Default([]) List<ServiceRecordEntity> records,
  }) = _GarageVehicleEntity;

  String get title => '$make $model';

  ServiceRecordEntity? get lastOil {
    final oils = records.where((r) => r.oil).toList()
      ..sort((a, b) {
        final kmOrder = b.km.compareTo(a.km);
        return kmOrder == 0 ? b.date.compareTo(a.date) : kmOrder;
      });
    return oils.isEmpty ? null : oils.first;
  }

  factory GarageVehicleEntity.fromJson(Map<String, dynamic> json) =>
      _$GarageVehicleEntityFromJson(json);
}
